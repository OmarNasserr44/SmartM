import 'dart:io';

import 'package:ar_smart_wear/Widgets/ItemsPreviewBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TryOutfits extends StatefulWidget {
  final File image;
  final double distBet2Shoulders;
  final double distBetHipsAndShoulders;
  final double rightShoulderXco;
  final double rightShoulderYco;
  final double boundingBoxInPixels;
  final double topPositionedShirt;
  final double distanceBetTwoHips;
  final double distanceBetHipsAndFeet;

  const TryOutfits(
      {this.image,
      this.distBet2Shoulders,
      this.distBetHipsAndShoulders,
      this.rightShoulderXco,
      this.rightShoulderYco,
      this.boundingBoxInPixels,
      this.topPositionedShirt,
      this.distanceBetTwoHips,
      this.distanceBetHipsAndFeet});
  @override
  _TryOutfitsState createState() => _TryOutfitsState(
        image: image,
        distBet2Shoulders: distBet2Shoulders,
        distBetHipsAndShoulders: distBetHipsAndShoulders,
        rightShoulderYco: rightShoulderYco,
        rightShoulderXco: rightShoulderXco,
        boundingBoxInPixels: boundingBoxInPixels,
        topPositionedShirt: topPositionedShirt,
        distanceBetTwoHips: distanceBetTwoHips,
        distanceBetHipsAndFeet: distanceBetHipsAndFeet,
      );
}

class _TryOutfitsState extends State<TryOutfits> {
  final File image;
  final double distBet2Shoulders;
  final double distBetHipsAndShoulders;

  final double rightShoulderXco;
  final double rightShoulderYco;
  final double boundingBoxInPixels;
  final double topPositionedShirt;
  final double distanceBetTwoHips;
  final double distanceBetHipsAndFeet;

  //since google pose detection wasn't accurate in positioning the landmark exactly on the shoulders specially the right shoulder which
  //we are interested in as we take it as our reference to position the shirt to start from the detected person shoulders
  //I used the position of the Bounding Box from the left side as the reference for our shirt to start as the Bounding Box fit the
  //detected person exactly. but for the top positioning we can't estimate the starting point of the shirt
  //therefore I calculated the distance between the top of the bounding box and the start of the shoulders of the detected person
  //and used an Image as a reference and I found it to be 70px, and since the distance between top of the bounding box and the shoulders
  //are almost the same at any standing person, therefore I figured out a constant which is that 70px divided by the height of the bounding
  //box, now if we multiplied it with any bounding box height it will give us the estimated distance between the top of the head of the
  //detected person and his shoulders
  double factoredH(double h) {
    return ((70 / 528.2392964848375) * h) + topPositionedShirt;
  }

  _TryOutfitsState(
      {this.distanceBetHipsAndFeet,
      this.distanceBetTwoHips,
      this.topPositionedShirt,
      this.boundingBoxInPixels,
      this.rightShoulderXco,
      this.rightShoulderYco,
      this.distBetHipsAndShoulders,
      this.distBet2Shoulders,
      this.image});

  String changeableOutfit = "assets/Images/emptyPNG.png";
  String pants = "assets/Images/emptyPNG.png";

  @override
  Widget build(BuildContext context) {
    print("hipsandfeet $distanceBetHipsAndFeet");
    print("2shoulders $distBet2Shoulders");
    print("2Hips $distanceBetTwoHips");
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: screenSize.width / 20,
        centerTitle: true,
        title: Text(
          "Try OutFits",
          style: GoogleFonts.gloriaHallelujah(fontSize: screenSize.width / 12),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: screenSize.height / 1.5,
                          width: screenSize.width,
                          child: Image.file(image),
                        ),
                        Positioned(
                            right: screenSize.width / 30,
                            top: screenSize.height / 100,
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  changeableOutfit =
                                      "assets/Images/emptyPNG.png";
                                  pants = "assets/Images/emptyPNG.png";
                                });
                              },
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.cancel_outlined,
                                size: screenSize.width / 8,
                              ),
                            )),
                        Positioned(
                          left: rightShoulderXco,
                          top: factoredH(boundingBoxInPixels) +
                              distBetHipsAndShoulders -
                              30,
                          child: Container(
                            child: Image.asset(
                              pants,
                              fit: BoxFit.cover,
                            ),
                            height: distanceBetHipsAndFeet,
                            width: distanceBetTwoHips,
                          ),
                        ),
                        Positioned(
                          left: rightShoulderXco,
                          top: factoredH(boundingBoxInPixels),
                          child: Container(
                            child: Image.asset(
                              changeableOutfit,
                            ),
                            height: distBetHipsAndShoulders,
                            width: distBet2Shoulders,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height / 4.7,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              changeableOutfit =
                                  "assets/Images/menTop/open-jacket2.png";
                            });
                          },
                          child: PreviewBox(
                            screenSize: screenSize,
                            imagePath: "assets/Images/menTop/open-jacket2.png",
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              changeableOutfit =
                                  "assets/Images/menTop/white-shirt.png";
                            });
                          },
                          child: PreviewBox(
                            screenSize: screenSize,
                            imagePath: "assets/Images/menTop/white-shirt.png",
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              changeableOutfit =
                                  "assets/Images/menTop/jacket2.png";
                            });
                          },
                          child: PreviewBox(
                            screenSize: screenSize,
                            imagePath: "assets/Images/menTop/jacket2.png",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pants = "assets/Images/menBottom/black-p2.png";
                            });
                          },
                          child: PreviewBox(
                            screenSize: screenSize,
                            imagePath: "assets/Images/menBottom/black-p2.png",
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pants = "assets/Images/menBottom/black-p.png";
                            });
                          },
                          child: PreviewBox(
                            screenSize: screenSize,
                            imagePath: "assets/Images/menBottom/black-p.png",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
