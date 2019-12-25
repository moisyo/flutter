import 'package:flutter/material.dart';
import 'package:flutter_mqtt_location_example/converter.dart';
import 'package:flutter_mqtt_location_example/constants.dart' as Constants;
import 'package:location/location.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'models.dart';

class MQTTClientWrapper {
  //MqttClient
  MqttClient client;
  //convert.dart
  LocationToJsonConverter locationToJsonConverter = LocationToJsonConverter();
  JsonToLocationConverter jsonToLocationConverter = JsonToLocationConverter();

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;
  //引数として受け取るコールバック関数
  final VoidCallback onConnectedCallback;
  final Function(LocationData) onLocationReceivedCallback;
  //コンストラクタ
  MQTTClientWrapper(this.onConnectedCallback, this.onLocationReceivedCallback);
  //mqttclientをセットアップし、mqttに接続し、subする関数
  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient();
    _subscribeToTopic(Constants.topicName);
  }

//pubの時はJson形式に変換
  void publishLocation(LocationData locationData) {
    String locationJson = locationToJsonConverter.convert(locationData);
    _publishMessage(locationJson);
  }

  Future<void> _connectClient() async {
    try {
      //接続を試みている間
      print('MQTTClientWrapper::Mosquitto client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect();
    } on Exception catch (e) {
      //接続を試みている間に接続がうまくいかず例外が発生した時
      print('MQTTClientWrapper::client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
//接続が成功した時
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('MQTTClientWrapper::Mosquitto client connected');
    } else {
      //接続に失敗した時
      print(
          'MQTTClientWrapper::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  //MqttClientのセットアップのための関数
  void _setupMqttClient() {
    //MqttClientのコンストラクタ(String server,String clientIdentifier,int port)
    client = MqttClient.withPort(Constants.serverUri, '#', Constants.port);
    //ログを取るかの設定？
    client.logging(on: false);
    //int seconds
    client.keepAlivePeriod = 20;
    //接続が切れたときに呼び出されるコールバックを同クラス内で定義した関数に設定
    client.onDisconnected = _onDisconnected;

    ///接続がつながった時に呼び出されるコールバックを同クラス内で定義した関数に設定
    client.onConnected = _onConnected;
    //subした時に呼び出されるコールバックを同クラス内で定義した関数に設定
    client.onSubscribed = _onSubscribed;
  }

  //subする関数
  void _subscribeToTopic(String topicName) {
    print('MQTTClientWrapper::Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);
    //Stream<List<MqttReceivedMessage<MqttMessage>>>　メッセージ(新しい位置情報)を受け取った時
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String newLocationJson =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print("MQTTClientWrapper::GOT A NEW MESSAGE $newLocationJson");
      LocationData newLocationData = _convertJsonToLocation(newLocationJson);
//      (newLocationJson) => gotNewLocation(newLocationJson))
      if (newLocationData != null) onLocationReceivedCallback(newLocationData);
    });
  }

  LocationData _convertJsonToLocation(String newLocationJson) {
    try {
      return jsonToLocationConverter.convert(newLocationJson);
    } catch (exception) {
      print("Json can't be formatted ${exception.toString()}");
    }
    return null;
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print(
        'MQTTClientWrapper::Publishing message $message to topic ${Constants.topicName}');
    //引数(String topic, MqttQos qualityOfService, Unit8Buffer data)
    client.publishMessage(
        Constants.topicName, MqttQos.exactlyOnce, builder.payload);
  }

  void _onSubscribed(String topic) {
    print('MQTTClientWrapper::Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print(
        'MQTTClientWrapper::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print(
          'MQTTClientWrapper::OnDisconnected callback is solicited, this is correct');
    }
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print(
        'MQTTClientWrapper::OnConnected client callback - Client connection was sucessful');
//() => locationWrapper.prepareLocationMonitoring()　位置監視の準備
    onConnectedCallback();
  }
}
