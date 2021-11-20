import 'package:flutter/material.dart';
import 'package:shop/models/History.dart';
import 'package:shop/utils/Api.dart';
import 'package:shop/utils/Cons.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<History> histories = [];

  _loadHistories() async {
    bool bol = await Api.getHistories();
    if (bol) {
      histories = Cons.histories;
    } else {
      print(Cons.errMsg);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadHistories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Ur History")),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: histories.length,
                  itemBuilder: (context, index) =>
                      _buildOrder(histories[index])))
        ]));
  }

  _buildOrder(History history) {
    return Container(
      color: Cons.normal,
      child: history.items.length > 0
          ? ExpansionTile(
              title: _buildExpandableTitle(history),
              children: List.generate(history.items.length,
                  (index) => _buildItem(history.items[index])),
            )
          : null,
    );
  }

  _buildItem(Item item) {
    return Container(
      color: Cons.accent,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.network(item.images[0], scale: 3.5),
        Column(children: [
          Text("${item.name}"),
          Text("${item.count} * ${item.price}")
        ]),
        _makeTextButton("${item.price * item.count}")
      ]),
    );
  }

  _buildExpandableTitle(History history) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _makeWhiteText("${history.items[0].created.split("T")[0]}"),
      _makeTextButton("${Cons.getItemTotal(history.items)} Ks")
    ]);
  }

  _makeTextButton(text) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            backgroundColor: Cons.darkGrey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)))),
        child: _makeWhiteText(text, fsize: 16.0));
  }

  _makeWhiteText(text, {fsize = 18.0}) {
    return Text(text,
        style: TextStyle(
            fontSize: fsize, color: Cons.primary, fontFamily: "English"));
  }
}
