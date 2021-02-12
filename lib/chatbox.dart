import 'package:flutter/foundation.dart';

class ChatBox with ChangeNotifier {
  List<ChatMessage> chats = [];

  String _message;

  void setMessage(String msg) => _message = msg;

  void addChat({bool isMyMessage}) {
    var chatMessage = ChatMessage(message: _message, isMyMessage: isMyMessage);
    chats.add(chatMessage);
    notifyListeners();
  }
}

class ChatMessage {
  final String message;
  final bool isMyMessage;

  ChatMessage({@required this.message, @required this.isMyMessage});
}
