import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/core/models/chat_notificaton.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  List<ChatNotification> get items {
    return [...items];
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
