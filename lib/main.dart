import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/pages/auth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
