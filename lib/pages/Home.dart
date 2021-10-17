import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/Category.dart';
import 'package:shop/utils/Cons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _makeTitleBar("Tag"),
            Container(
              height: 250,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                      "assets/images/${Cons.slideImages[index]}");
                },
                itemCount: Cons.slideImages.length,
                pagination: SwiperPagination(),
                autoplay: true,
                viewportFraction: 0.6,
                scale: 0.9,
              ),
            ),
            _makeTitleBar("Categories"),
            GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: Cons.cats?.length,
                itemBuilder: (context, index) =>
                    _makeGridCard(Cons.cats![index]))
          ],
        ),
      ),
    ));
  }

  Widget _makeGridCard(Category cat) {
    return Container(
      child: Card(
        child: Image.network(cat.image ?? ""),
      ),
    );
  }

  Widget _makeTitleBar(text) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Cons.secondary,
          borderRadius: BorderRadius.only(topRight: Radius.circular(100))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 3),
        child: Text(text,
            style: TextStyle(
                fontSize: 40,
                fontFamily: "English",
                color: Cons.normal,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
