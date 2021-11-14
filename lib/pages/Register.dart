import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/helpers/TrianglePainter.dart';
import 'package:shop/utils/Api.dart';
import 'package:shop/utils/Cons.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();
  var _phoneErrorText = "";
  var _isShow = true;
  var _nameController = TextEditingController(text: "Ba La");
  var _emailController = TextEditingController(text: "bala@gmail.com");
  var _phoneController = TextEditingController(text: "09100100100");
  var _passwordController = TextEditingController(text: "123123123");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              CustomPaint(painter: TrianglePainter(size)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Image.asset("assets/images/fm.png", width: 130)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                      child: Text("Register",
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: "English",
                              color: Cons.normal,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 20),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  errorText: _phoneErrorText,
                                  labelText: "Name",
                                  labelStyle: _getTextStyle(),
                                  errorBorder: _getInputBorder(),
                                  enabledBorder: _getInputBorder(),
                                  focusedBorder: _getInputBorder()),
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  errorText: _phoneErrorText,
                                  labelText: "Email",
                                  labelStyle: _getTextStyle(),
                                  errorBorder: _getInputBorder(),
                                  enabledBorder: _getInputBorder(),
                                  focusedBorder: _getInputBorder()),
                            ),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
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
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var json = jsonEncode({
                                          "name": _nameController.text,
                                          "email": _emailController.text,
                                          "phone": _phoneController.text,
                                          "password": _passwordController.text
                                        });
                                        print(json);
                                        bool bol =
                                            await Api.register(json: json);
                                        if (bol) {
                                          Navigator.pop(context);
                                        }
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
                                        Text("Register",
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
