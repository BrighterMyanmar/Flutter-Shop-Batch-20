class Message {
  Msg from, to;
  String type, msg, created;

  Message(
      {required this.from,
      required this.to,
      required this.type,
      required this.msg,
      required this.created});

  factory Message.fromJson(dynamic data) {
    Msg from = Msg.fromJson(data["from"]);
    Msg to = Msg.fromJson(data["to"]);
    return Message(
        type: data["type"],
        msg: data["msg"],
        created: data["created"],
        from: from,
        to: to);
  }
}

class Msg {
  String id, name;

  Msg({required this.id, required this.name});

  factory Msg.fromJson(dynamic data) {
    return Msg(id: data["_id"], name: data["name"]);
  }
}
