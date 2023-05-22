import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cod3r_chat/core/models/chat_user.dart';
import 'package:flutter_cod3r_chat/core/models/chat_message.dart';
import 'package:flutter_cod3r_chat/core/services/chat/chat_service.dart';

class ChatFirebaseService implements ChatService {
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageURL': user.imageURL,
    });

    return null;
  }
}
