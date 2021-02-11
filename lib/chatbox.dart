import 'package:flutter/foundation.dart';

class ChatBox with ChangeNotifier {
  List<String> chats = [];
  // int value = 0;

  // void increment() {
  //   value += 1;
  //   notifyListeners();
  // }

  void addChat(String message) {
    chats.add(message);
    notifyListeners();
  }
}
