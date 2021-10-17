import 'package:flutter/material.dart';
import 'package:shop/models/Category.dart';
import 'package:shop/utils/Api.dart';

class ProductPage extends StatefulWidget {
  Category? cat;

  ProductPage({Key? key, this.cat}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(this.cat);
}

class _ProductPageState extends State<ProductPage> {
  Category? cat;
  int page = 1;

  _ProductPageState(this.cat);

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _loadCatProducts() async {
    await Api.getCatProducts(id: cat?.id ?? 0, page: page);
  }

  @override
  void initState() {
    super.initState();
    _loadCatProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${cat?.name}")),
    );
  }
}
