import 'package:flutter/material.dart';
import 'package:flutter_app/display.dart';

void main() => runApp(getTest());

class getTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: display(),
    );
  }
}
