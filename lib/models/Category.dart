class Category {
  String? id, name, image, created;
  List<SubCat>? subcats;

  Category({this.id, this.name, this.image, this.created, this.subcats});

  factory Category.fromJson(dynamic data) {
    List lisy = data["subcats"] as List;
    List<SubCat> sbcats = lisy.map((e) => SubCat.fromJson(e)).toList();
    return Category(
        id: data["_id"],
        name: data["name"],
        image: data["image"],
        created: data["created"],
        subcats: sbcats);
  }
}

class SubCat {
  String? id, name, image;
  List<ChildCat>? childcats;

  SubCat({this.id, this.name, this.image, this.childcats});

  factory SubCat.fromJson(dynamic data) {
    List lisy = data["childcats"] as List;
    List<ChildCat> chcats = lisy.map((e) => ChildCat.fromJson(e)).toList();
    return SubCat(
        id: data["_id"],
        name: data["name"],
        image: data["image"],
        childcats: chcats);
  }
}

class ChildCat {
  String? id, name, image;

  ChildCat({this.id, this.name, this.image});

  factory ChildCat.fromJson(dynamic data) {
    return ChildCat(id: data["_id"], name: data["name"], image: data["image"]);
  }
}
