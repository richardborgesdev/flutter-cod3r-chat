import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_cod3r_chat/core/services/auth/auth_service.dart';

import '../../models/chat_user.dart';

class AuthMockService implements AuthService {
  static final _defaulUser = ChatUser(
    id: '1',
    name: 'Teste',
    email: 'teste@test.com.br',
    imageURL: 'assets/images/avatar.png',
  );
  static final Map<String, ChatUser> _users = {
    _defaulUser.email: _defaulUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaulUser);
  });

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageURL: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
