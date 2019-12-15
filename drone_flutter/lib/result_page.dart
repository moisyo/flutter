import 'package:flutter/material.dart';
import 'package:drone_flutter/pub_data.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    main();
  }

  void main() async {
//    int data = await compute(PubData, 'success');
    int data = await PubData();
    print('test1 $data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Text('送信完了')],
      ),
    );
  }
}
