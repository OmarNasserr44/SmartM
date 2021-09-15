import 'package:ar_smart_wear/Screens/CameraScreen.dart';
import 'package:ar_smart_wear/Widgets/CustButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderScreen extends StatefulWidget {
  static const id = "GenderScreen";
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Choose Your Gender",
              style: GoogleFonts.gloriaHallelujah(
                  fontSize: screenSize.width / 10,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenSize.height / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustButton(
                  screenSize: screenSize,
                  heightDiv: screenSize.width / 36,
                  widthDiv: screenSize.width / 163.6363636,
                  text: "Man",
                  onTap: () {
                    Navigator.pushNamed(context, CameraScreen.id);
                  },
                ),
                SizedBox(
                  width: screenSize.width / 20,
                ),
                CustButton(
                  screenSize: screenSize,
                  heightDiv: screenSize.width / 36, //10
                  widthDiv: screenSize.width / 163.6363636, //2.2
                  text: "Woman",
                  onTap: () {
                    Navigator.pushNamed(context, CameraScreen.id);
                  },
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenSize.height / 2,
                  width: screenSize.width / 3,
                  child: Image.asset("assets/Images/man.png"),
                ),
                SizedBox(
                  width: screenSize.width / 6,
                ),
                Container(
                  height: screenSize.height / 2,
                  width: screenSize.width / 3,
                  child: Image.asset("assets/Images/woman.png"),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height / 15,
            ),
            Text(
              "-Smart Retail-",
              style: GoogleFonts.gloriaHallelujah(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
