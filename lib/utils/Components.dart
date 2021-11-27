import 'package:flutter/material.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/pages/Cart.dart';
import 'package:shop/utils/Cons.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class Components {
  static List<Product> cartProducts = [];

  static String SOCKET_ENDPOINT =
      "${Cons.BASE_URL}/chat?token=${Cons.user?.token}";

  static IO.Socket? socket;

  static getSocket() {
    socket = IO.io(
        SOCKET_ENDPOINT,
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    socket?.onConnect((_) {
      print("Socket Connected");
    });
  }

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

  static addProductCount(Product product) {
    cartProducts.forEach((pro) {
      if (pro.id == product.id) {
        pro.count++;
      }
    });
  }

  static reduceProductCount(Product product) {
    cartProducts.forEach((pro) {
      if (pro.id == product.id) {
        if (pro.count > 1) {
          pro.count--;
        }
      }
    });
  }

  static removeProduct(Product product) {
    cartProducts.removeWhere((pro) => pro.id == product.id);
  }

  static int getProductTotal() {
    int total = 0;
    cartProducts.forEach((pro) {
      total += (pro.price ?? 0) * pro.count;
    });
    return total;
  }

  static genOrderProducts() {
    List<Map> cartList = [];
    cartProducts.forEach((product) {
      var map = new Map();
      map["id"] = product.id;
      map["count"] = product.count;
      cartList.add(map);
    });
    return cartList;
  }

  static Widget getShoppingCart(context, count) {
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
                  child: Text(count.padLeft(2, "0"),
                      style: TextStyle(
                          fontFamily: "English", color: Colors.white))),
            ),
          )
        ],
      ),
    );
  }
}
