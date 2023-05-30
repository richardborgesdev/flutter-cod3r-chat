import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/core/services/notification/chat_notification_service.dart';
import 'package:flutter_cod3r_chat/pages/auth_page.dart';
import 'package:flutter_cod3r_chat/pages/chat_page.dart';
import 'package:flutter_cod3r_chat/pages/loading_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../core/models/chat_user.dart';
import '../core/services/auth/auth_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
    await Provider.of<ChatNotificationService>(
      context,
      listen: false,
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage();
              } else {
                return snapshot.hasData ? ChatPage() : AuthPage();
              }
            },
          );
        }
      },
    );
  }
}
