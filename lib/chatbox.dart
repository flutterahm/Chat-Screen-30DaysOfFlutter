import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatBox with ChangeNotifier {
  List<ChatMessage> chats = [];

  String _message;

  void setMessage(String msg) => _message = msg;

  void addChat({bool isMyMessage}) {
    var chatMessage = ChatMessage(message: _message, isMyMessage: isMyMessage);
    chats.add(chatMessage);
    notifyListeners();
    persistChats(chats);
  }

  Future<void> persistChats(List<ChatMessage> chatMessages) async {
    //TODO: Persist
    print('Storing chats to Hive box');
    var box = await Hive.openBox('myBox');

    String chatMessaagesString = chatMessageToJson(chatMessages);
    box.put('myChats', chatMessaagesString);

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('myChats', chatMessaagesString);
  }

  Future<void> retriveChats() async {
    // TODO: retrive the mesages
    print('Retriving chats from Hive');
    var box = await Hive.openBox('myBox');
    String chatMessagesString = box.get('myChats');
    List<ChatMessage> allChats = chatMessageFromJson(chatMessagesString);
    chats = allChats;
    notifyListeners();
  }
}
// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

List<ChatMessage> chatMessageFromJson(String str) => List<ChatMessage>.from(
    json.decode(str).map((x) => ChatMessage.fromJson(x)));

String chatMessageToJson(List<ChatMessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMessage {
  ChatMessage({
    this.message,
    this.isMyMessage,
  });

  String message;
  bool isMyMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        message: json["message"],
        isMyMessage: json["isMyMessage"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isMyMessage": isMyMessage,
      };
}
