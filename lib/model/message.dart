class Message {
  late String address;
  late String body;
  late String dateSent;

  Message({required this.address, required this.body, required this.dateSent});

  Message.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    body = json['body'];
    dateSent = json['dateSent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['body'] = this.body;
    data['dateSent'] = this.dateSent;
    return data;
  }
}
