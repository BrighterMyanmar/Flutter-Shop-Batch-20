class History {
  bool status;
  List<Item> items;

  History({required this.status, required this.items});

  factory History.fromJson(dynamic data) {
    List lisy = data["items"] as List;
    List<Item> itm = lisy.map((e) => Item.fromJson(e)).toList();
    return History(status: data["status"], items: itm);
  }
}

class Item {
  List<dynamic> images;
  int discount, count, price;
  bool status;
  String id, order, productId, name, created;

  Item(
      {required this.images,
      required this.discount,
      required this.count,
      required this.price,
      required this.status,
      required this.id,
      required this.order,
      required this.productId,
      required this.name,
      required this.created});

  factory Item.fromJson(dynamic data) {
    List<dynamic> imgs = data["images"] as List;
    return Item(
      images: imgs,
      discount: data["discount"],
      status: data["status"],
      id: data["_id"],
      order: data["order"],
      count: data["count"],
      productId: data["productId"],
      name: data["name"],
      price: data["price"],
      created: data["created"],
    );
  }
}
