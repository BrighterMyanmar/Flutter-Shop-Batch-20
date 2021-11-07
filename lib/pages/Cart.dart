import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/pages/Login.dart';
import 'package:shop/utils/Components.dart';
import 'package:shop/utils/Cons.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Your Cart")),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: Components.cartProducts.length,
                  itemBuilder: (context, index) =>
                      _buildCartItem(Components.cartProducts[index]))),
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Cons.secondary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Sub Total", style: _getBigTextStyle(Cons.primary)),
                    Text("${Components.getProductTotal()} Ks",
                        style: _getBigTextStyle(Cons.normal))
                  ],
                ),
                SizedBox(height: 30),
                TextButton(
                    onPressed: () {
                      if (Cons.user == null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        var items = Components.genOrderProducts();
                        var json = jsonEncode({
                          "user": "605c19163bac7310fb16aabb",
                          "total": 20000,
                          "biker": "605c19163bac7310fb16aabb",
                          "items": items
                        });
                        print(json);
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Cons.normal,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                    child: Text("Order Now",
                        style: TextStyle(color: Cons.primary, fontSize: 20)))
              ],
            ),
          )
        ]));
  }

  Widget _buildCartItem(Product product) {
    return Stack(overflow: Overflow.visible, children: [
      Container(
        height: 130,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Card(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.images![0],
                width: 150,
              ),
              Expanded(
                  child: Column(
                children: [
                  Text("${product.name}", style: _getBigTextStyle(Cons.normal)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildRichText("Price ${product.price} Ks\n",
                          "Total ${(product.price ?? 0) * product.count} Ks"),
                      _buildCountGroup(product)
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
      Positioned(
        right: -5,
        top: -13,
        child: TextButton(
            onPressed: () {
              Components.removeProduct(product);
              setState(() {});
            },
            style: TextButton.styleFrom(
                backgroundColor: Cons.accent,
                minimumSize: Size(15, 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            child: Icon(Icons.clear, color: Cons.primary, size: 15)),
      ),
    ]);
  }

  Widget _buildCountGroup(Product product) {
    return Row(children: [
      TextButton(
          onPressed: () {
            Components.reduceProductCount(product);
            setState(() {});
          },
          style: TextButton.styleFrom(
              backgroundColor: Cons.normal,
              padding: EdgeInsets.zero,
              minimumSize: Size(30, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
          child: Icon(Icons.remove, color: Cons.primary)),
      Text("${product.count}".padLeft(2, "0"),
          style: TextStyle(fontSize: 20, color: Cons.normal)),
      TextButton(
          onPressed: () {
            Components.addProductCount(product);
            setState(() {});
          },
          style: TextButton.styleFrom(
              backgroundColor: Cons.normal,
              padding: EdgeInsets.zero,
              minimumSize: Size(30, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
          child: Icon(Icons.add, color: Cons.primary))
    ]);
  }

  _getBigTextStyle(color) {
    return TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: color,
        fontFamily: "English");
  }

  Widget _buildRichText(text, discount) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: text,
          style: TextStyle(
              fontSize: 14,
              color: Cons.normal,
              fontWeight: FontWeight.bold,
              fontFamily: "English")),
      TextSpan(
          text: discount,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Cons.normal,
              fontFamily: "English"))
    ]));
  }
}
