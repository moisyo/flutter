import 'package:flutter/material.dart';
import 'package:flutter_mqtt_location_example/locationWrapper.dart';
import 'package:flutter_mqtt_location_example/mqttClientWrapper.dart';
import 'package:flutter_mqtt_location_example/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_mqtt_location_example/constants.dart' as Constants;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MQTT Location Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter MQTT Location'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MQTTClientWrapper mqttClientWrapper;
  LocationWrapper locationWrapper;

  LocationData currentLocation;

  GoogleMapController _controller;

  void setup() {
    //変数locationWrapperでLocationWrapperクラスを使えるようにする
    locationWrapper = LocationWrapper(
        (newLocation) => mqttClientWrapper.publishLocation(newLocation));
    //変数mqttClientWrapperでMQTTClientWrapperクラスを使えるようにする
    mqttClientWrapper = MQTTClientWrapper(
        () => locationWrapper.prepareLocationMonitoring(),
        (newLocationJson) => gotNewLocation(newLocationJson));
    //MQTTClientWrapperクラスのメソッドでmqttclientをセットアップし、接続し、subする
    mqttClientWrapper.prepareMqttClient();
  }

  //新しい位置情報を受けた時の関数
  void gotNewLocation(LocationData newLocationData) {
    //位置情報の変化をアプリの描画に即座に反映させるためにsetState
    setState(() {
      this.currentLocation = newLocationData;
    });
    animateCameraToNewLocation(newLocationData);
  }

  //新しい位置にマップを移動させる関数
  void animateCameraToNewLocation(LocationData newLocation) {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(newLocation.latitude, newLocation.longitude),
        zoom: Constants.newZoom)));
  }

  @override
  void initState() {
    super.initState();

    //アプリが立ち上がった時にセットアップを実行
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: mqttClientWrapper.connectionState !=
              MqttCurrentConnectionState.CONNECTED
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("CONNECTING TO MQTT..."),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(Constants.defaultLocation.latitude,
                      Constants.defaultLocation.longitude),
                  zoom: Constants.defaultZoom),
              markers: currentLocation == null
                  ? Set()
                  : [
                      Marker(
                          markerId: MarkerId(Constants.defaultMarkerId),
                          position: LatLng(currentLocation.latitude,
                              currentLocation.longitude))
                    ].toSet(),
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  this._controller = controller;
                });
              },
            ),
    );
  }
}
