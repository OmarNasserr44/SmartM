import 'dart:io';

import 'package:ar_smart_wear/Widgets/NumBelowText.dart';
import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({
    Key key,
    @required this.screenSize,
    @required this.height,
    @required this.neck,
    @required this.chest,
    @required this.shoulder,
    @required this.image,
  }) : super(key: key);

  final Size screenSize;
  final int height;
  final double neck;
  final double chest;
  final double shoulder;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height / 1.5,
      width: screenSize.width / 1.05,
      child: Row(
        children: [
          SizedBox(
            width: screenSize.width / 20,
          ),
          Column(
            children: [
              NumBelowText(
                screenSize: screenSize,
                height: height.toDouble(),
                text: "Height",
              ),
              NumBelowText(screenSize: screenSize, height: neck, text: "Neck"),
              NumBelowText(
                screenSize: screenSize,
                height: chest,
                text: "chest",
              ),
              NumBelowText(
                screenSize: screenSize,
                height: shoulder,
                text: "Shoulder",
              ),
            ],
          ),
          SizedBox(
            width: screenSize.width / 20,
          ),
          Container(
            height: screenSize.height / 2.2,
            width: screenSize.width / 72,
            color: Colors.blue,
          ),
          SizedBox(
            width: screenSize.width / 30,
          ),
          Container(
            height: screenSize.height / 1.8,
            width: screenSize.width / 2.3,
            child: Image.file(image),
          ),
        ],
      ),
    );
  }
}
