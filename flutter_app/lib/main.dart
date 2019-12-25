import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Title(),
        ),
        body: Mywidget(),
      ),
    );
  }
}

class Mywidget extends StatefulWidget {
  @override
  _MywidgetState createState() => _MywidgetState();
}

class _MywidgetState extends State<Mywidget> {
  foo() async {
    int result =
        await compute(_calculatet, 5); // computeIntに渡したい引数をcomputeの第二引数に指定

    print(result);
  }

  static int _calculatet(int value) {
    // 時間がかかるCPUヘビーな処理
    return value * 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: FlatButton(onPressed: foo, child: Text('Push')),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'test',
      style: TextStyle(fontSize: 30.0, color: Colors.lightBlueAccent),
    );
  }
}
