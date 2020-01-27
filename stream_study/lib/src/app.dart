import 'package:flutter/material.dart';
import 'package:stream_study/src/screens/login_screen.dart';
import 'blocs/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'LOG ME IN',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
