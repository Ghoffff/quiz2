import 'package:flutter/material.dart';
import 'package:flutter_mentor_quiz_app_tut/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        primaryColor: Color(0xFF6F35A5),
      ),
      home: Home(),
    );
  }
}
