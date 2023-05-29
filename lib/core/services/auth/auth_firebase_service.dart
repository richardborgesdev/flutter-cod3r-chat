import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cod3r_chat/core/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../models/chat_user.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);

      controller.add(_currentUser);
    }
  });

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );

    final auth = FirebaseAuth.instanceFor(app: signup);

    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      // 1. Upload da foto do usuário
      final imageName = '${credential.user!.uid}.jpg';
      final imageUrl = await _uploadUserImage(
        image,
        imageName,
      );

      // 2. atualizar os atributos do usuário
      await credential.user?.updateDisplayName(name);
      await credential.user?.updatePhotoURL(imageUrl);

      // 2.5 fazer o login do usuário
      await login(email, password);

      // 3. salvar usuário no banco de dados (opcional)
      _currentUser = _toChatUser(
        credential.user!,
        name,
        imageUrl,
      );
      await _saveChatUser(_currentUser!);
    }

    await signup.delete();
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage
        .ref() // ref is default bucket
        .child('user_images')
        .child(imageName);
    await imageRef.putFile(image).whenComplete(() {});

    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageURL,
    });
  }

  static ChatUser _toChatUser(User user, [String? name, String? imageURL]) {
    return ChatUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: imageURL ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
