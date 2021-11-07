class User {
  String? id, name, email, phone, token;

  User({this.id, this.name, this.email, this.phone, this.token});

  factory User.fromJson(dynamic data) {
    return User(
      id: data["id"],
      name: data["name"],
      email: data["email"],
      phone: data["phone"],
      token: data["token"],
    );
  }
}
