import 'dart:io';
import 'package:ar_smart_wear/Screens/TryOutfitsScreen.dart';
import 'package:ar_smart_wear/Widgets/CustButton.dart';
import 'package:ar_smart_wear/Widgets/ReportWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:height_slider/height_slider.dart';

class BodyMeasurements extends StatefulWidget {
  static const id = "Body Measurements";
  final File image;
  final double distBet2Shoulders;
  final double distBetLeftHipAndShoulder;
  final double distBetRightHipAndShoulder;
  final double distanceBetTwoHips;
  final double boundingBoxInPixels;
  final double rightShoulderXco;
  final double rightShoulderYco;
  final double topPositionedShirt;
  final double distanceBetHipsAndFeet;

  const BodyMeasurements({
    this.image,
    this.distBet2Shoulders,
    this.distBetLeftHipAndShoulder,
    this.distBetRightHipAndShoulder,
    this.boundingBoxInPixels,
    this.rightShoulderXco,
    this.rightShoulderYco,
    this.topPositionedShirt,
    this.distanceBetTwoHips,
    this.distanceBetHipsAndFeet,
  });
  @override
  _BodyMeasurementsState createState() => _BodyMeasurementsState(
        image: image,
        boundingBoxInPixels: boundingBoxInPixels,
        distBet2Shoulders: distBet2Shoulders,
        distBetLeftHipAndShoulder: distBetLeftHipAndShoulder,
        distBetRightHipAndShoulder: distBetRightHipAndShoulder,
        rightShoulderXco: rightShoulderXco,
        rightShoulderYco: rightShoulderYco,
        topPositionedShirt: topPositionedShirt,
        distanceBetTwoHips: distanceBetTwoHips,
        distanceBetHipsAndFeet: distanceBetHipsAndFeet,
      );
}

class _BodyMeasurementsState extends State<BodyMeasurements> {
  _BodyMeasurementsState(
      {this.distanceBetHipsAndFeet,
      this.distanceBetTwoHips,
      this.topPositionedShirt,
      this.rightShoulderXco,
      this.rightShoulderYco,
      this.boundingBoxInPixels,
      this.distBet2Shoulders,
      this.distBetLeftHipAndShoulder,
      this.distBetRightHipAndShoulder,
      this.image});

  final File image;
  final double distBet2Shoulders;
  final double distBetLeftHipAndShoulder;
  final double distBetRightHipAndShoulder;
  final double boundingBoxInPixels;
  final double rightShoulderXco;
  final double rightShoulderYco;
  final double topPositionedShirt;
  final double distanceBetTwoHips;
  final double distanceBetHipsAndFeet;

  //
  int height = 170;
  double neck = 0;
  double chest = 0;
  double shoulder = 0;
  bool gotHeight = false;
  //

  double convertPixelsToCM(var cm1, double pixel_1, double pixel_2) {
    double cm2 = 0;
    cm2 = (pixel_2 * cm1) / pixel_1;
    return cm2.ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Size Report",
          style: GoogleFonts.gloriaHallelujah(fontSize: screenSize.width / 12),
        ),
      ),
      body: SafeArea(
        child: !gotHeight
            ? Center(
                child: Stack(
                  children: [
                    HeightSlider(
                      height: height,
                      onChange: (val) {
                        setState(() {
                          height = val;
                        });
                      },
                      unit: 'cm', // optional
                      maxHeight: 210,
                      currentHeightTextColor: Colors.red,
                    ),
                    Positioned(
                        left: screenSize.width / 12,
                        top: screenSize.height / 15,
                        child: CustButton(
                          onTap: () {
                            setState(() {
                              chest = convertPixelsToCM(height,
                                  boundingBoxInPixels, distBet2Shoulders);
                              gotHeight = true;
                            });
                          },
                          fillColor: Colors.blue,
                          screenSize: screenSize,
                          text: "Next",
                          fontSize: screenSize.width / 14,
                          textColor: Colors.white,
                          heightDiv: screenSize.height / 60,
                          widthDiv: screenSize.width / 120,
                        )),
                  ],
                ),
              )
            : Container(
                height: screenSize.height,
                width: screenSize.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height / 25,
                    ),
                    ReportWidget(
                        screenSize: screenSize,
                        height: height,
                        neck: neck,
                        chest: chest,
                        shoulder: shoulder,
                        image: image),
                    SizedBox(
                      height: screenSize.height / 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustButton(
                          screenSize: screenSize,
                          onTap: () {
                            setState(() {
                              gotHeight = false;
                            });
                          },
                          text: "Remeasure",
                          heightDiv: screenSize.height / 90,
                          widthDiv: screenSize.width / 160,
                          fontSize: screenSize.width / 18,
                        ),
                        SizedBox(
                          width: screenSize.width / 30,
                        ),
                        CustButton(
                          screenSize: screenSize,
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TryOutfits(
                                            image: image,
                                            distBet2Shoulders:
                                                distBet2Shoulders,
                                            distBetHipsAndShoulders:
                                                distBetRightHipAndShoulder >
                                                        distBetLeftHipAndShoulder
                                                    ? distBetRightHipAndShoulder
                                                    : distBetLeftHipAndShoulder,
                                            rightShoulderXco: rightShoulderXco,
                                            rightShoulderYco: rightShoulderYco,
                                            boundingBoxInPixels:
                                                boundingBoxInPixels,
                                            topPositionedShirt:
                                                topPositionedShirt,
                                            distanceBetHipsAndFeet:
                                                distanceBetHipsAndFeet,
                                            distanceBetTwoHips:
                                                distanceBetTwoHips,
                                          )));
                            });
                          },
                          text: "Try Outfits",
                          heightDiv: screenSize.height / 90,
                          widthDiv: screenSize.width / 160,
                          fontSize: screenSize.width / 18,
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
