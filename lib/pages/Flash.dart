import 'package:flutter/material.dart';
import 'package:shop/helpers/TrianglePainter.dart';
import 'package:shop/utils/Api.dart';
import 'package:shop/utils/Cons.dart';

class Flash extends StatefulWidget {
  const Flash({Key? key}) : super(key: key);

  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  _loadInitialData() async {
    bool bol = await Api.getCats();
    bool tagBool = await Api.getTags();
    if (bol && tagBool) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      print("Data Loading Error!");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          CustomPaint(
            painter: TrianglePainter(mSize),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("Food Monkey",
                    style: TextStyle(
                        fontSize: 40,
                        color: Cons.normal,
                        fontFamily: "English",
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 40),
              Image.asset("assets/images/fm.png"),
              SizedBox(height: 40),
              CircularProgressIndicator(
                color: Cons.accent,
                backgroundColor: Cons.normal,
              )
            ],
          )
        ],
      ),
    ));
  }
}
