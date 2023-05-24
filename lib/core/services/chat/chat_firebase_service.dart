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
    final docRef = await store
        .collection('chat')
        // .withConverter(
        //   fromFirestore: fromFirestore,
        //   toFirestore: toFirestore,
        // )
        .add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageURL': user.imageURL,
    });

    final doc = await docRef.get();
    final data = doc.data();

    return ChatMessage(
      id: doc.id,
      text: data?['text'],
      createdAt: DateTime.parse(data?['createdAt']),
      userId: data?['userId'],
      userName: data?['userName'],
      userImageURL: data?['userImageURL'],
    );
  }

  ChatMessage _fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageURL: doc['userImageURL'],
    );
  }

  Map<String, dynamic> _toFirestore(ChatMessage msg, SetOptions? options) {
    return {
      'text': msg.text,
      'createdAt': msg.createdAt.toIso8601String(),
      'userId': msg.userId,
      'userName': msg.userName,
      'userImageURL': msg.userImageURL,
    };
  }
}
