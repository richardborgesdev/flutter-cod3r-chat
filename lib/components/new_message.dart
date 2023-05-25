import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/core/services/auth/auth_service.dart';
import 'package:flutter_cod3r_chat/core/services/chat/chat_service.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  final _messageControler = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      final msg = await ChatService().save(_enteredMessage, user);
      _messageControler.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageControler,
            onChanged: (msg) => setState(() => _enteredMessage = msg),
            decoration: InputDecoration(
              labelText: 'Enviar mensagem...',
            ),
            onSubmitted: (_) {
              if (_enteredMessage.trim().isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ),
        IconButton(
          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          icon: Icon(Icons.send),
        ),
      ],
    );
  }
}
