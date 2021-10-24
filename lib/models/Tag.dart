class Tag {
  String? id, name, image;

  Tag({this.id, this.name, this.image});

  factory Tag.fromJson(dynamic data) {
    return Tag(id: data["_id"], name: data["name"], image: data["image"]);
  }
}
