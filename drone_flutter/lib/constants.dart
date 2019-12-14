import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'データを入力',
  fillColor: Colors.black54,
  focusColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0))),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
