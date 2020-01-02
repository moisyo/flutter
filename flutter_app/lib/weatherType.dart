import 'Network.dart';

const apiKey = '41ae4bf82ba95d54898a2cfee8fa52cb';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Network networkHelper = Network(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric&lang=ja');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

//  Future<dynamic> getLocationWeather() async {
//
//
//    Network networkHelper = Network(
//        '$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
//
//    var weatherData = await networkHelper.getData();
//
//    return weatherData;
//  }

//  String getWeatherIcon(int condition) {
//    if (condition < 300) {
//      return '🌩';
//    } else if (condition < 400) {
//      return '🌧';
//    } else if (condition < 600) {
//      return '☔️';
//    } else if (condition < 700) {
//      return '☃️';
//    } else if (condition < 800) {
//      return '🌫';
//    } else if (condition == 800) {
//      return '☀️';
//    } else if (condition <= 804) {
//      return '☁️';
//    } else {
//      return '🤷‍';
//    }
//  }
}
