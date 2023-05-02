import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';

  void _sendMessage() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Enviar mensagem...',
            ),
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
