import 'package:flutter/material.dart';
import 'package:shop/utils/Cons.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var boxWidth = (width / 3) * 2;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("Chat With Customer Service")),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _makeLeftText(boxWidth),
                  _makeRightImage(boxWidth, "assets/images/bur.png"),
                  _makeRightText(boxWidth),
                  _makeLeftImage(boxWidth, "assets/images/1.png")
                ],
              ),
            )),
            _makeMessageBar()
          ],
        ));
  }

  _makeMessageBar() {
    return Container(
      height: 55,
      color: Cons.normal,
      child: Row(children: [
        Icon(Icons.upload_file, size: 45, color: Cons.primary),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: TextFormField(
                  controller: _messageController,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))),
        InkWell(
            onTap: () {
              var msg = _messageController.text;
              print(msg);
            },
            child: Icon(Icons.send, size: 45, color: Cons.primary)),
      ]),
    );
  }

  _makeRightImage(boxWidth, imgLink) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Cons.normal,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Image.asset(imgLink, scale: 3.5),
        ),
      ],
    );
  }

  _makeLeftImage(boxWidth, imgLink) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Cons.normal,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25))),
      child: Image.asset(imgLink, scale: 3.5),
    );
  }

  _makeLeftText(boxWidth) {
    return Container(
        width: boxWidth,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, top: 5),
        decoration: BoxDecoration(
            color: Cons.secondary,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: _makeChatUsername("Hacky Chang")),
            _makeChatParagraph(Cons.SAMPLE_TEXT),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _makeChatDate("2021-11-20")),
              ],
            )
          ],
        ));
  }

  _makeRightText(boxWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            width: boxWidth,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(right: 5, top: 5),
            decoration: BoxDecoration(
                color: Cons.secondary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: _makeChatUsername("Biber Tester",
                        colour: Cons.primary)),
                _makeChatParagraph(Cons.SAMPLE_TEXT),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _makeChatDate("2021-11-20")),
                  ],
                )
              ],
            )),
      ],
    );
  }

  _makeChatUsername(text, {colour = Cons.normal}) {
    return Text(text,
        style: TextStyle(
            color: colour, fontWeight: FontWeight.bold, fontFamily: "English"));
  }

  _makeChatParagraph(text) {
    return Text(text,
        style:
            TextStyle(fontSize: 16, color: Cons.normal, fontFamily: "Burmese"));
  }

  _makeChatDate(text) {
    return Text(text,
        style: TextStyle(
            color: Cons.normal,
            fontWeight: FontWeight.bold,
            fontFamily: "English"));
  }
}
