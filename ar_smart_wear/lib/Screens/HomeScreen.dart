import 'package:ar_smart_wear/Screens/GenderScreen.dart';
import 'package:ar_smart_wear/Widgets/CustButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Smart Retail",
          style: GoogleFonts.gloriaHallelujah(fontSize: screenSize.width / 12),
        ),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                // Colors.blue,
                Colors.white,
                Colors.white,
                // Colors.yellow,
                // Colors.greenAccent,
              ])),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height / 1.8,
                ),
                CustButton(
                  screenSize: screenSize,
                  text: "Start",
                  onTap: () {
                    Navigator.pushNamed(context, GenderScreen.id);
                  },
                ),
              ],
            ),
          )),
    );
  }
}
