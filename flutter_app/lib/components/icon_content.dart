import 'package:flutter/material.dart';
import '../constants.dart';

class IconContent extends StatelessWidget {
  IconContent({this.temp, this.label, this.onPress});

  final double temp;
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$temp ℃',
          style: TextStyle(fontSize: 30.0),
        ),
        SizedBox(
          height: 15.0,
        ),
        RaisedButton(
          child: Text(label),
          color: Colors.black54,
          shape: StadiumBorder(
            side: BorderSide(color: Colors.green),
          ),
          onPressed: onPress,
        ),
      ],
    );
  }
}
