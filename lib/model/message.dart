import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String address;
  final String body;
  final String name;

  Message({required this.address, required this.body, required this.name});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

class MessageList {
  late final List<Message> listMessage;

  MessageList({required this.listMessage});

  factory MessageList.fromJson(List<dynamic> parsedJson) {
    List<Message> listMessage =
        parsedJson.map((e) => Message.fromJson(e)).toList();
    return MessageList(listMessage: listMessage);
  }
}
