import 'package:flutter/material.dart';

import 'package:drone_flutter/input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Input(),
    );
  }
}
