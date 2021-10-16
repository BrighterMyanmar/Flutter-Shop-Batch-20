import 'package:flutter/material.dart';
import 'package:shop/helpers/TrianglePainter.dart';
import 'package:shop/pages/Home.dart';
import 'package:shop/utils/Api.dart';

class Flash extends StatefulWidget {
  const Flash({Key? key}) : super(key: key);

  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  _loadInitialData() async {
    // await Future.delayed(Duration(seconds: 5));
    bool bol = await Api.getCats();
    if (bol) {
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
                        color: Colors.pink,
                        fontFamily: "English",
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 40),
              Image.asset("assets/images/fm.png"),
              SizedBox(height: 40),
              CircularProgressIndicator(
                color: Colors.amberAccent,
                backgroundColor: Colors.pink,
              )
            ],
          )
        ],
      ),
    ));
  }
}
