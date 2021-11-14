import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/models/Category.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/models/Tag.dart';
import 'package:shop/models/User.dart';
import 'package:shop/utils/Cons.dart';

class Api {
  static Future<bool> login({json}) async {
    Uri uri = Uri.parse("${Cons.API_URL}/login");
    var response = await http.post(uri, body: json, headers: Cons.header);
    var responseData = jsonDecode(response.body);

    if (responseData["con"]) {
      Cons.user = User.fromJson(responseData["result"]);
      return true;
    } else {
      print(responseData["msg"]);
      return false;
    }
  }

  static Future<bool> register({json}) async {
    Uri uri = Uri.parse("${Cons.API_URL}/register");
    var response = await http.post(uri, body: json, headers: Cons.header);
    var responseData = jsonDecode(response.body);
    if (responseData["con"]) {
      return true;
    } else {
      print(responseData["msg"]);
      return false;
    }
  }

  static Future<bool> orderUpload({json}) async {
    Uri uri = Uri.parse("${Cons.API_URL}/orders");
    var response = await http.post(uri, body: json, headers: Cons.tokenHeader);
    var responseData = jsonDecode(response.body);
    if (responseData["con"]) {
      return true;
    } else {
      print(responseData["msg"]);
      return false;
    }
  }

  static Future<bool> getCats() async {
    Uri uri = Uri.parse("${Cons.API_URL}/cats");
    var response = await http.get(uri);

    var responseData = jsonDecode(response.body);

    if (responseData["con"]) {
      List lisy = responseData["result"] as List;
      Cons.cats = lisy.map((e) => Category.fromJson(e)).toList();
      return true;
    } else {
      print(responseData["msg"]);
      return false;
    }
  }

  static Future<List<Product>> getCatProducts({id, page}) async {
    List<Product> products = [];
    Uri uri = Uri.parse("${Cons.API_URL}/catproducts/$id/$page");
    var response = await http.get(uri);
    var responseData = jsonDecode(response.body);
    if (responseData["con"]) {
      List lisy = responseData["result"] as List;
      products = lisy.map((e) => Product.fromJson(e)).toList();
    }
    return products;
  }

  static Future<List<Product>> getTagProducts({id, page}) async {
    List<Product> products = [];
    Uri uri = Uri.parse("${Cons.API_URL}/tagproducts/$id/$page");
    var response = await http.get(uri);
    var responseData = jsonDecode(response.body);
    if (responseData["con"]) {
      List lisy = responseData["result"] as List;
      products = lisy.map((e) => Product.fromJson(e)).toList();
    }
    return products;
  }

  static Future<bool> getTags() async {
    Uri uri = Uri.parse("${Cons.API_URL}/tags");
    var response = await http.get(uri);

    var responseData = jsonDecode(response.body);
    if (responseData["con"]) {
      List lisy = responseData["result"] as List;
      Cons.tags = lisy.map((e) => Tag.fromJson(e)).toList();
      return true;
    } else {
      print(responseData["msg"]);
      return false;
    }
  }
}
