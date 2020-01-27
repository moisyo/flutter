import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      //スクロールしたら更なるrowを表示するためitemBuilderがrerunされる
      itemBuilder: (context, int index) {
        return FutureBuilder(
          //futureが無事resolveされたら
          future: getFuture(),
          //builder が rerunされる
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Text('Im visible $index')
                : Text('I havent fetch  data yet $index');
          },
        );
      },
    );
  }

//2秒たったらfutureを自動的にresolve(pending state→fulfilled state)してhi'というStringを返す
  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'hi',
    );
  }
}
