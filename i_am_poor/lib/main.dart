import 'package:flutter/material.dart';

void main() {runApp(MaterialApp(
  home: Scaffold(
    backgroundColor: Colors.amberAccent,
    appBar: AppBar(
      title: Text('i am poor'),
      backgroundColor: Colors.blueGrey,
    ),
    body: Center(
      child: Image(image: AssetImage('images/51vYqzJ5mOL._SX466_.jpg')),
    ),
  ),
));

}

