import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shop/models/Message.dart';
import 'package:shop/utils/Components.dart';
import 'package:shop/utils/Cons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  File? file;
  List<Message> chats = [];

  _invokeSocket() {
    Components.socket?.emit('load-more', "");
    Components.socket?.on("message", (data) {
      Message msg = Message.fromJson(data);
      chats.add(msg);
      setState(() {
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 200,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn);
      });
    });
    Components.socket?.on("messages", (data) {
      List lisy = data as List;
      chats = lisy.map((e) => Message.fromJson(e)).toList();
      setState(() {});
    });
  }

  _emitMessage(msg, type) {
    var sendMsg = new Map();
    sendMsg["from"] = Cons.user?.id;
    sendMsg["to"] = Cons.SHOP_ID;
    sendMsg["type"] = type;
    sendMsg["msg"] = msg;
    Components.socket?.emit("message", sendMsg);
  }

  @override
  void initState() {
    super.initState();
    _invokeSocket();
  }

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
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      Message chat = chats[index];
                      if (chat.from.id == Cons.user?.id) {
                        if (chat.type == "text") {
                          return _makeLeftText(chat, boxWidth);
                        } else {
                          return _makeLeftImage(chat.msg, boxWidth);
                        }
                      } else {
                        if (chat.type == "text") {
                          return _makeRightText(chat, boxWidth);
                        } else {
                          return _makeRightImage(chat.msg, boxWidth);
                        }
                      }
                    })),
            _makeMessageBar()
          ],
        ));
  }

  _makeMessageBar() {
    return Container(
      height: 55,
      color: Cons.normal,
      child: Row(children: [
        InkWell(
            onTap: () => _getImage(),
            child: Icon(Icons.upload_file, size: 45, color: Cons.primary)),
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
              _emitMessage(msg, "text");
            },
            child: Icon(Icons.send, size: 45, color: Cons.primary)),
      ]),
    );
  }

  _makeRightImage(imgLink, boxWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: boxWidth,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Cons.normal,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Image.network(imgLink, scale: 3.5),
        ),
      ],
    );
  }

  _makeLeftImage(imgLink, boxWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: boxWidth,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              color: Cons.normal,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          child: Image.network(imgLink, scale: 1.2),
        ),
      ],
    );
  }

  _makeLeftText(chat, boxWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
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
                    child: _makeChatUsername(chat.from.name)),
                _makeChatParagraph(chat.msg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _makeChatDate(chat.created.split("T")[0])),
                  ],
                )
              ],
            )),
      ],
    );
  }

  _makeRightText(chat, boxWidth) {
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
                    child: _makeChatUsername(chat.from.name,
                        colour: Cons.primary)),
                _makeChatParagraph(chat.msg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _makeChatDate(chat.created.split("T")[0])),
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

  Future _getImage() async {
    final result = await _picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      print("${result.path}");
      file = File(result.path);
      _uploadImage();
    }
  }

  _uploadImage() async {
    var galleryUrl = Uri.parse("${Cons.BASE_URL}/api/imageupload");
    http.MultipartRequest request = http.MultipartRequest('POST', galleryUrl);
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("image", file?.path ?? "");
    request.files.add(multipartFile);
    request.headers["Authorization"] = "Bearer ${Cons.user?.token}";

    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        var resData = jsonDecode(value);
        _emitMessage(resData["msg"], "image");
      });
    });
  }
}
