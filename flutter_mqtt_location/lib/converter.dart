import 'dart:convert';

import 'package:location/location.dart';

class LocationToJsonConverter {
  String convert(LocationData input) {
    return "{\"latitude\":${input.latitude},\"longitude\":${input.longitude}}";
  }
}

class JsonToLocationConverter {
  LocationData convert(String input) {
    //json形式の位置情報データをDartオブジェクトに変換
    Map<String, dynamic> jsonInput = jsonDecode(input);
    //mapデータからインスタンスを生成
    return LocationData.fromMap({
      'latitude': jsonInput['latitude'],
      'longitude': jsonInput['longitude'],
    });
  }
}
