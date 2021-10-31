import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/utils/Cons.dart';

class Detail extends StatefulWidget {
  final Product product;

  const Detail({Key? key, required this.product}) : super(key: key);

  @override
  _DetailState createState() => _DetailState(this.product);
}

class _DetailState extends State<Detail> {
  Product product;

  _DetailState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Product Detail")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                Container(
                  height: 150,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(product.images![index]);
                    },
                    itemCount: Cons.slideImages.length,
                    pagination: SwiperPagination(),
                    autoplay: true,
                    viewportFraction: 0.6,
                    scale: 0.9,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${product.name}",
                        style: TextStyle(
                            fontSize: 45,
                            color: Cons.normal,
                            fontWeight: FontWeight.bold,
                            fontFamily: "English")),
                    Stack(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Center(
                                child: Text("10".padLeft(2, "0"),
                                    style: TextStyle(
                                        fontFamily: "English",
                                        color: Colors.white))),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildRichText("Price\n", "\t\t\t${product.price} Ks"),
                      _buildRichText("Size\n", "\t${product.size}"),
                      _buildRichText("Promo\n", "\t\t\t\t\t${product.discount}")
                    ]),
                SizedBox(height: 10),
                _makeDescText("${product.desc}"),
                SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Cons.normal, width: 0.5),
                  children: [
                    TableRow(children: [
                      _makeTableTitleText("Features"),
                      _makeTableTitleText("Values")
                    ]),
                    ...List.generate(product.features?.length ?? 0, (index) {
                      var feature = product?.features?[index];
                      var key = feature.keys.toList()[0];
                      return _makeTableRow(key, feature[key]);
                    })
                  ],
                ),
                SizedBox(height: 10),
                _makeDescText("${product.detail}"),
                SizedBox(height: 10),
                Text(
                  "Delivery",
                  style: TextStyle(
                      fontSize: 25, fontFamily: "English", color: Cons.normal),
                ),
                SizedBox(height: 10),
                ...List.generate(product.deliveris?.length ?? 0, (index) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      Image.network("${product.deliveris![0].image}")
                    ],
                  );
                }),
                SizedBox(height: 10),
                Text(
                  "Warranty",
                  style: TextStyle(
                      fontSize: 25, fontFamily: "English", color: Cons.normal),
                ),
                SizedBox(height: 10),
                ...List.generate(product.warranties?.length ?? 0, (index) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      Image.network("${product.warranties![0].image}")
                    ],
                  );
                }),
                SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }

  TableRow _makeTableRow(key, value) {
    return TableRow(
        children: [_makeTableRowText("$key"), _makeTableRowText("$value")]);
  }

  Widget _makeTableRowText(text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Text(text,
            style: TextStyle(
                fontFamily: "Burmese", fontSize: 18, color: Cons.normal)),
      ),
    );
  }

  Widget _makeTableTitleText(text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(text,
            style: TextStyle(
                fontFamily: "English", fontSize: 20, color: Cons.accent)),
      ),
    );
  }

  Widget _makeDescText(text) {
    return Text(text,
        textAlign: TextAlign.justify,
        style:
            TextStyle(fontSize: 18, color: Cons.normal, fontFamily: "Burmese"));
  }

  Widget _buildRichText(text, discount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: text,
            style: TextStyle(
                fontSize: 30, color: Cons.normal, fontFamily: "English")),
        TextSpan(
            text: discount,
            style: TextStyle(
                fontSize: 16,
                color: Cons.accent,
                fontWeight: FontWeight.bold,
                fontFamily: "English"))
      ])),
    );
  }
}
