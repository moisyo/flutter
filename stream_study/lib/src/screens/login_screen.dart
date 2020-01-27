import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          SizedBox(
            height: 25.0,
            width: 25.0,
          ),
          submitButton(bloc),
        ],
      ),
    );
  }

  Widget emailField(bloc) {
    return StreamBuilder(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'you@example.com',
              labelText: 'Email Address',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget passwordField(bloc) {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget submitButton(bloc) {
    return StreamBuilder<Object>(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text('Login'),
            color: Colors.blue,
            onPressed: snapshot.hasData ? bloc.submit : null,
          );
        });
  }
}