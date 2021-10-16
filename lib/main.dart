import 'package:flutter/material.dart';
import 'package:shop/pages/Flash.dart';
import 'package:shop/pages/Home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => Flash(),
      "/home":(context) => Home()
    },
  ));
}
