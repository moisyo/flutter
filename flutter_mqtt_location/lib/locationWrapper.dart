import 'package:location/location.dart';

class LocationWrapper {
  //locationパッケージ
  var location = new Location();
  final Function(LocationData) onLocationChanged;
  //コンストラクタ
  LocationWrapper(this.onLocationChanged);

  void prepareLocationMonitoring() {
    //位置情報へのアクセス許可があるかどうか→Future<bool>
    location.hasPermission().then((bool hasPermission) {
      //アクセス許可がなければ
      if (!hasPermission) {
        //アクセス許可をリクエスト→Future<bool>
        location.requestPermission().then((bool permissionGranted) {
          //リクエストが許可されれば
          if (permissionGranted) {
            _subscribeToLocation();
          }
        });
        //アクセス許可があれば
      } else {
        _subscribeToLocation();
      }
    });
  }

  void _subscribeToLocation() {
    //位置情報が変化した場合→位置情報を返すStream<LocationData>
    location.onLocationChanged().listen((LocationData newLocation) {
      //変化した位置情報をコールバック関数にセット
      onLocationChanged(newLocation);
    });
  }
}
