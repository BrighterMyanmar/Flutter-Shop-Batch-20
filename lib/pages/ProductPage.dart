import 'package:flutter/material.dart';
import 'package:shop/models/Category.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/utils/Api.dart';
import 'package:shop/utils/Cons.dart';

class ProductPage extends StatefulWidget {
  Category? cat;

  ProductPage({Key? key, this.cat}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(this.cat);
}

class _ProductPageState extends State<ProductPage> {
  Category? cat;
  int page = 1;
  List<Product> products = [];

  _ProductPageState(this.cat);

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _loadCatProducts() async {
    List<Product> prods =
        await Api.getCatProducts(id: cat?.id ?? 0, page: page);
    products.addAll(prods);
    setState(() {});
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
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) =>
                      _makeProductCard(products[index])),
            )
          ],
        ));
  }

  Widget _makeProductCard(Product product) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Card(
        color: Cons.primary,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("Burger With Beef",
                style: TextStyle(
                    fontFamily: "English",
                    fontSize: 18,
                    color: Cons.normal,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Image.asset("assets/images/1.png",width:120),
            // Image.network(
            //   "${product.images![0]}",
            //   width: 130,
            // ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Cons.accent,
                  size: 30,
                ),
                Text("${product.price} Ks",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "English",
                        color: Cons.normal,
                        fontWeight: FontWeight.bold)),
                Icon(Icons.remove_red_eye_outlined,
                    size: 30, color: Cons.accent)
              ],
            )
          ],
        ),
      ),
    );
  }
}
