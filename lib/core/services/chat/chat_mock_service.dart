import 'dart:async';
import 'dart:math';

import 'package:flutter_cod3r_chat/core/models/chat_user.dart';
import 'package:flutter_cod3r_chat/core/models/chat_message.dart';
import 'package:flutter_cod3r_chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Opa',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'test1',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Opa',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'test2',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Opa',
      createdAt: DateTime.now(),
      userId: '789',
      userName: 'test3',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    _msgs.add(newMessage);
    _controller?.add(_msgs);

    return newMessage;
  }
}
