class Product {
  List<dynamic>? images;
  int? discount, price;
  List<dynamic>? features;
  List<dynamic>? colors;
  List<Delivery>? deliveris;
  List<Warranty>? warranties;
  bool? status;
  String? id, name, brand, size, desc, detail;
  double? rating;
  int count = 1;

  Product(
      {this.images,
      this.discount,
      this.features,
      this.status,
      this.deliveris,
      this.warranties,
      this.id,
      this.name,
      this.brand,
      this.size,
      this.desc,
      this.detail,
      this.rating,
      this.colors,
      this.price});

  factory Product.fromJson(dynamic data) {
    List<dynamic> fts = data["features"] as List;
    List<dynamic> cols = data["colors"] as List;
    List lisy = data["delivery"] as List;
    List<Delivery> dlis = lisy.map((e) => Delivery.fromJson(e)).toList();
    List wlis = data["warranty"] as List;
    List<Warranty> warList = wlis.map((e) => Warranty.fromJson(e)).toList();
    return Product(
        images: data["images"],
        discount: data["discount"],
        features: fts,
        status: data["status"],
        deliveris: dlis,
        warranties: warList,
        id: data["_id"],
        name: data["name"],
        brand: data["brand"],
        size: data["size"],
        desc: data["desc"],
        detail: data["detail"],
        rating: data["rating"],
        price: data["price"],
        colors: cols);
  }
}

class Delivery {
  int? price;
  String? id, name, duration, image;
  List<dynamic>? remarks;

  Delivery(
      {this.remarks,
      this.id,
      this.name,
      this.price,
      this.duration,
      this.image});

  factory Delivery.fromJson(dynamic data) {
    List<dynamic> rmks = data["remarks"] as List;
    return Delivery(
      remarks: rmks,
      id: data["_id"],
      name: data["name"],
      price: data["price"],
      duration: data["duration"],
      image: data["image"],
    );
  }
}

class Warranty {
  String? id, name, image;
  List<dynamic>? remark;

  Warranty({this.remark, this.id, this.name, this.image});

  factory Warranty.fromJson(dynamic data) {
    List<dynamic> rmks = data["remark"] as List;
    return Warranty(
        remark: rmks,
        id: data["_id"],
        name: data["name"],
        image: data["image"]);
  }
}
