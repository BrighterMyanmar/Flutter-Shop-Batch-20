import 'package:flutter/material.dart';
import 'package:shop/models/Category.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/models/Tag.dart';
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

  // Loading
  // When to Load
  _ProductPageState(this.cat);

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  var _selectedIndex = 0;
  var type = "category";

  _loadCatProducts() async {
    setState(() {
      isLoading = true;
    });
    // await Future.delayed(Duration(seconds: 5));
    List<Product> prods = [];
    if (type == "category") {
      prods = await Api.getCatProducts(id: cat?.id ?? 0, page: page);
    } else {
      var tagId = Cons.tags?[_selectedIndex]?.id ?? 0;
      prods = await Api.getTagProducts(id: tagId, page: page);
    }

    products.addAll(prods);
    page++;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCatProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("${cat?.name}")),
        body: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Cons.tags?.length,
                  itemBuilder: (context, index) =>
                      _makeNavTab(index, Cons.tags![index])),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoading &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      _loadCatProducts();
                    }
                    return false;
                  },
                  child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) =>
                          _makeProductCard(products[index]))),
            ),
            Container(child: isLoading ? CircularProgressIndicator() : null)
          ],
        ));
  }

  Widget _makeNavTab(index, Tag tag) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              _selectedIndex = index;
              type = "tags";
              page = 1;
              products = [];
              setState(() {
                _loadCatProducts();
              });
            },
            child: Text("${tag.name}",
                style: TextStyle(
                    fontFamily: "English",
                    fontWeight: FontWeight.bold,
                    color: Cons.normal,
                    fontSize: 18)),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            width: 50,
            height: 5,
            color: index == _selectedIndex ? Cons.accent : Colors.transparent,
          )
        ],
      ),
    );
  }

  Widget _makeProductCard(Product product) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Card(
        color: Cons.primary,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("${product.name}",
                style: TextStyle(
                    fontFamily: "English",
                    fontSize: 18,
                    color: Cons.normal,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Image.asset("assets/images/1.png", width: 120),
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
