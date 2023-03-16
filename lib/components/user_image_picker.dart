import 'dart:io';

import 'package:flutter/material.dart';

class UserPickerImage extends StatefulWidget {
  final void Function(File image) onImagepick;

  const UserPickerImage({
    Key? key,
    required this.onImagepick,
  }) : super(key: key);

  @override
  State<UserPickerImage> createState() => _UserPickerImageState();
}

class _UserPickerImageState extends State<UserPickerImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
        )
      ],
    );
  }
}
