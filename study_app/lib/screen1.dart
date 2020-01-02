import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class screen1 extends StatefulWidget {
  @override
  _screen1State createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("タイトル"),
            content: Text("メッセージ"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Delete"),
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(),
              onChanged: (newText) {
//                print(newText);
                if (newText != null) {
                  _showAlertDialog();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
