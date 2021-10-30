import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shop/helpers/ArcPainter.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/utils/Cons.dart';

class PreviewPage extends StatefulWidget {
  final Product product;

  const PreviewPage({Key? key, required this.product}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState(this.product);
}

class _PreviewPageState extends State<PreviewPage> {
  Product product;

  _PreviewPageState(this.product);

  @override
  Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Product Preview")),
        body: SingleChildScrollView(
            child: Stack(children: [
          CustomPaint(
            painter: ArcPainter(mSize),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("${product.name}",
                  style: TextStyle(
                      fontSize: 45,
                      fontFamily: "English",
                      fontWeight: FontWeight.bold,
                      color: Cons.normal)),
            ),
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
            _buildRichText(
                "Price\n", "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t5500 Ks"),
            _buildRichText("Size\n", "\t\t\t\t\t\t\t\t\t\tLarge Size"),
            _buildRichText(
                "Promo\n", "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tCoca Cola"),
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Cons.normal,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: TextButton(
                      onPressed: () {},
                      // style: TextButton.styleFrom(
                      //     backgroundColor: Cons.normal,
                      //     padding: EdgeInsets.all(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size: 35,
                              color: Cons.primary,
                            ),
                            Text("Buy Now",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "English",
                                    color: Cons.primary))
                          ],
                        ),
                      )),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Cons.normal,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text("Detail...",
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "English",
                                color: Cons.primary)),
                      )),
                ),
              ],
            ),
            SizedBox(height: 50)
          ]),
        ])));
  }

  Widget _buildRichText(text, discount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: text, style: TextStyle(fontSize: 65, fontFamily: "English")),
        TextSpan(
            text: discount,
            style: TextStyle(
                fontSize: 20,
                color: Cons.normal,
                fontWeight: FontWeight.bold,
                fontFamily: "English"))
      ])),
    );
  }
}
