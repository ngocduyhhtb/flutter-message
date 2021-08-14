import 'dart:convert';

import 'package:chat_app/model/message.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';

class MessageRepository {
  final _logger = Logger();

  Future<String> getJson(String fileName) {
    return rootBundle.loadString(fileName);
  }

  Future<MessageList> loadAllInboxMessage() async {
    final data = await getJson('assets/inbox.json');
    var jsonData = jsonDecode(data);
    return MessageList.fromJson(jsonData);
  }

  Future<MessageList> loadAllSentMessage() async {
    final data = await getJson('assets/sent.json');
    var jsonData = jsonDecode(data);
    return MessageList.fromJson(jsonData);
  }
}
