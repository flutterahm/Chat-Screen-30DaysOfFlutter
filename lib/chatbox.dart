import 'package:flutter/foundation.dart';

class ChatBox with ChangeNotifier {
  List<String> chats = [];

  String _message;

  void setMessage(String msg) => _message = msg;

  void addChat() {
    chats.add(_message);
    notifyListeners();
  }
}
