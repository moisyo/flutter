import 'package:flutter/material.dart';
import 'package:drone_data_getter_flutter/input.dart';

import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';

final MqttClient client = MqttClient('test.mosquitto.org', '');

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Input(),
    );
  }
}
