import 'dart:io';

import 'package:ar_smart_wear/Screens/BodyMeasurementsScreen.dart';
import 'package:ar_smart_wear/Widgets/CustButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

class CameraScreen extends StatefulWidget {
  static const id = 'CameraScreen';
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String _model = ssd;
  File _image;

  double _imageWidth;
  double _imageHeight;
  bool _busy = false;

  List _recognitions;

  @override
  void initState() {
    super.initState();
    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      if (_model == yolo) {
        print("INSIDE YOLOO");
        res = await Tflite.loadModel(
          model: "assets/tflite/yolov2_tiny.tflite",
          labels: "assets/tflite/yolov2_tiny.txt",
        );
      } else {
        res = await Tflite.loadModel(
          model: "assets/tflite/ssd_mobilenet.tflite",
          labels: "assets/tflite/ssd_mobilenet.txt",
        );
      }
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  selectFromImagePicker(bool camera) async {
    var image;
    if (!camera) {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    predictImage(File(image.path));
  }

  predictImage(File image) async {
    if (image == null) return;

    if (_model == yolo) {
      await yolov2Tiny(image);
    } else {
      await ssdMobileNet(image);
    }

    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));

    setState(() {
      _image = image;
      _busy = false;
    });
  }

  yolov2Tiny(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        model: "YOLO",
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0,
        numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions;
    });
  }

  ssdMobileNet(File image) async {
    var recognitions = new List<dynamic>.from(await Tflite.detectObjectOnImage(
        path: image.path, numResultsPerClass: 1));
    var temp = new List<dynamic>.from(recognitions);

    dynamic recObject;
    for (recObject in recognitions) {
      if (recObject["detectedClass"] != "person") {
        // to only Detect Persons
        temp.removeAt(temp.indexOf(recObject));
      }
    }
    setState(() {
      _recognitions = temp;
    });
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageWidth * screen.width;
    print("FACTOR Y $factorY");

    Color blue = Colors.red;

    return _recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: blue,
            width: 3,
          )),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null
          ? Container(
              height: size.height / 1.5,
              width: size.width,
              child: Center(
                child: Text(
                  "No Image was \nSelected",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.gloriaHallelujah(
                      fontSize: size.width / 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            )
          : Image.file(_image),
    ));

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pick an Image",
          style: GoogleFonts.gloriaHallelujah(fontSize: size.width / 12),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustButton(
            screenSize: size,
            onTap: () {
              if (_image == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  content: Text(
                    "Please Upload an Image First",
                    style: GoogleFonts.gloriaHallelujah(),
                  ),
                ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BodyMeasurements(
                              image: _image,
                            )));
              }
            },
            text: "Next",
            fontSize: size.width / 13,
            heightDiv: size.height / 70,
            widthDiv: size.width / 110,
            fillColor: Colors.blue,
            textColor: Colors.white,
          ),
          SizedBox(
            width: size.width / 25,
          ),
          FloatingActionButton(
            child: Icon(Icons.camera),
            onPressed: () {
              selectFromImagePicker(true);
            },
            heroTag: "btn2",
          ),
          SizedBox(
            width: size.width / 25,
          ),
          FloatingActionButton(
            heroTag: "btn1",
            child: Icon(Icons.image),
            tooltip: "Pick Image from gallery",
            onPressed: () {
              selectFromImagePicker(false);
            },
          ),
        ],
      ),
      body: Stack(
        children: stackChildren,
      ),
    );
  }
}
