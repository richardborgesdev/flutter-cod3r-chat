import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chat page'),
            TextButton(
              onPressed: () {
                AuthService().logout();
              },
              child: Text('logout'),
            )
          ],
        ),
      ),
    );
  }
}
