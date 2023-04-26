import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/components/message_bubble.dart';
import 'package:flutter_cod3r_chat/core/models/chat_message.dart';
import 'package:flutter_cod3r_chat/core/services/auth/auth_service.dart';
import 'package:flutter_cod3r_chat/core/services/chat/chat_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text('Sem dados. Vamos conversar?'),
          );
        } else {
          final msgs = snapshot.data!;

          return ListView.builder(
            itemBuilder: (context, index) => MessageBubble(
                key: ValueKey(msgs[index].id),
                message: msgs[index],
                belongsToCurrentUser: currentUser?.id == msgs[index].userId),
            itemCount: msgs.length,
          );
        }
      },
      stream: ChatService().messagesStream(),
    );
  }
}
