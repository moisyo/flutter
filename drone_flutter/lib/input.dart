
import 'package:drone_flutter/result_page.dart';
import 'package:flutter/material.dart';
import 'package:drone_flutter/constants.dart';
import 'package:drone_flutter/rounded_button.dart';

class Input extends StatefulWidget {
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {},
              decoration: kTextFieldDecoration),
          RoundedButton(
            buttonTitle: '送信',
            colour: Colors.blueAccent,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResultPage()));
//              int data = await PubData();
//              print(data);
            },
          )
        ],
      ),
    );
  }
}
