import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/components/messages.dart';
import 'package:flutter_cod3r_chat/components/new_message.dart';
import 'package:flutter_cod3r_chat/pages/notification_page.dart';
import 'package:provider/provider.dart';

import '../core/services/auth/auth_service.dart';
import '../core/services/notification/chat_notification_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cod3r Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 10),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return NotificationPage();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.notifications),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      )),
    );
  }
}
