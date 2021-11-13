import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/helpers/TrianglePainter.dart';
import 'package:shop/utils/Cons.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  var _phoneErrorText = "";
  var _isShow = true;
  var _phoneController = TextEditingController(text: "09200200200");
  var _passwordController = TextEditingController(text: "@123!Abc");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              CustomPaint(painter: TrianglePainter(size)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(child: Image.asset("assets/images/fm.png")),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text("Login",
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: "English",
                              color: Cons.normal,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 30),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              // onChanged: (v) {
                              //   if (v.isNotEmpty) {
                              //     if (v.length < 11) {
                              //       _phoneErrorText =
                              //           "ဖုန်းနံပါတ် အများဆုံး ၁၁ လုံး ဖြစ်ရမယ်";
                              //     } else {
                              //       _phoneErrorText = "";
                              //     }
                              //     setState(() {});
                              //   }
                              // },
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "ဖုန်းနံပါတ် မထည့်လို့ မရဘူး";
                                }
                                if (v.length < 8) {
                                  return "ဖုန်းနံပါတ် အနည်းဆုံး ၈ လုံး ပါရမယ်";
                                }
                                if (v.length > 11) {
                                  return "ဖုန်းနံပါတ် အများဆုံး ၁၁ လုံး ဖြစ်ရမယ်";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  errorText: _phoneErrorText,
                                  labelText: "Phone",
                                  labelStyle: _getTextStyle(),
                                  errorBorder: _getInputBorder(),
                                  enabledBorder: _getInputBorder(),
                                  focusedBorder: _getInputBorder()),
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              obscureText: _isShow,
                              controller: _passwordController,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Password မပါ မရဘူး";
                                }
                                if (v.length < 8) {
                                  return "Password အနည်းဆုံး ၈ လုံး ပါရမယ်";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  suffixIcon: InkWell(
                                    onTap: () => _isShow = !_isShow,
                                    child: Icon(Icons.remove_red_eye,
                                        color: Cons.accent),
                                  ),
                                  labelStyle: _getTextStyle(),
                                  errorBorder: _getInputBorder(),
                                  enabledBorder: _getInputBorder(),
                                  focusedBorder: _getInputBorder()),
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("Not a member yet!\n Register herer!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Cons.normal,
                                            fontFamily: "English",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Container(
                                        width: 50,
                                        height: 5,
                                        color: Cons.accent)
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        var phone = _phoneController.text;
                                        var password = _passwordController.text;

                                        var json = jsonEncode({
                                          "phone": phone,
                                          "password": password
                                        });
                                        print(json);
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        backgroundColor: Cons.accent),
                                    child: Row(
                                      children: [
                                        Icon(Icons.lock, color: Cons.primary),
                                        SizedBox(width: 15),
                                        Text("Login",
                                            style: TextStyle(
                                                fontFamily: "English",
                                                fontSize: 18,
                                                color: Cons.primary))
                                      ],
                                    ))
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _getTextStyle() {
    return TextStyle(
        color: Cons.normal,
        fontFamily: "English",
        fontWeight: FontWeight.bold,
        fontSize: 20);
  }

  _getInputBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Cons.normal, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)));
  }
}
