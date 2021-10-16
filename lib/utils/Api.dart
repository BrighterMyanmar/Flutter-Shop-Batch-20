import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/models/Category.dart';
import 'package:shop/utils/Cons.dart';

class Api {
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
}
