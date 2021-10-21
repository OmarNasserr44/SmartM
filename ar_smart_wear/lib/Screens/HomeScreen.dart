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
          "Smart M",
          style: GoogleFonts.gloriaHallelujah(fontSize: screenSize.width / 12),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Images/background.jpeg"),
                  fit: BoxFit.cover),
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
                  height: screenSize.height / 5,
                ),
                Container(
                  height: screenSize.height / 6,
                  width: screenSize.width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    image: DecorationImage(
                        image: AssetImage("assets/Images/logo.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: screenSize.height / 5.2,
                ),
                CustButton(
                  screenSize: screenSize,
                  textColor: Colors.white,
                  borderColor: Colors.purple,
                  fillColor: Colors.purple,
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
