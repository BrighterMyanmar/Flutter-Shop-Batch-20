import 'package:flutter/material.dart';
import 'package:shop/models/Category.dart';
import 'package:shop/models/Tag.dart';
import 'package:shop/models/User.dart';

class Cons {
  static const Color primary = Color(0xFFF6F6F6);
  static const Color secondary = Color(0xFFFFBB91);
  static const Color accent = Color(0xFFFF8E6E);
  static const Color normal = Color(0xFF515070);
  static const Color yellow = Color(0xffFDC054);
  static const Color darkGrey = Color(0xff202020);
  static const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);
  static const String BASE_URL = "http://13.214.58.126:3000";
  static const String API_URL = "$BASE_URL/api";

  static List<Category>? cats;
  static List<Tag>? tags;
  static User? user;

  static List slideImages = ["1.png", "2.png", "3.png"];
}
