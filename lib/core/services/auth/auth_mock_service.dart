import 'dart:io';

import 'package:flutter_cod3r_chat/core/services/auth/auth_service.dart';

import '../../models/chat_user.dart';

class AuthMockService implements AuthService {
  static Map<String, ChatUser> _users = {};
  static ChatUser? _currentUser;

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {}

  Future<void> signup(
    String name,
    String email,
    String password,
    File image,
  ) async {}
  Future<void> login(String email, String password) async {}
  Future<void> logout() async {}
}
