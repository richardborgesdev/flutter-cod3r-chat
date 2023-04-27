import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/core/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  static final _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  Widget _showUserImage(String imageURL) {
    ImageProvider? imgProvider;
    final uri = Uri.parse(imageURL);

    if (uri.scheme.contains(_defaultImage)) {
      imgProvider = AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      imgProvider = NetworkImage(uri.toString());
    } else {
      imgProvider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: imgProvider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: belongsToCurrentUser
                      ? Colors.grey.shade300
                      : Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: belongsToCurrentUser
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    bottomRight: belongsToCurrentUser
                        ? Radius.circular(0)
                        : Radius.circular(12),
                  ),
                ),
                width: 180,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      message.userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white,
                      ),
                    ),
                    Text(
                      message.text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                )),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userImageURL),
        ),
      ],
    );
  }
}
