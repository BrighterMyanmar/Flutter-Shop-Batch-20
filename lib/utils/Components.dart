import 'package:flutter/material.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/pages/Cart.dart';
import 'package:shop/utils/Cons.dart';

class Components {
  static List<Product> cartProducts = [];

  static addToCart(Product product) {
    bool exist = false;
    if (cartProducts.length > 0) {
      cartProducts.forEach((p) {
        if (p.id == product.id) {
          exist = true;
          p.count++;
        }
      });
      if (!exist) {
        cartProducts.add(product);
      }
    } else {
      cartProducts.add(product);
    }
  }

  static Widget getShoppingCart(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      },
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Icon(Icons.shopping_cart, size: 45, color: Cons.accent),
          Positioned(
            right: 0,
            top: -10,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: Cons.normal,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                  child: Text(cartProducts.length.toString().padLeft(2, "0"),
                      style: TextStyle(
                          fontFamily: "English", color: Colors.white))),
            ),
          )
        ],
      ),
    );
  }
}
