import 'package:flutter/material.dart';
import 'components/reusable_card.dart';
import 'components/icon_content.dart';
import 'weatherType.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  WeatherModel weather = WeatherModel();
  double temp1 = 0;
  double temp2 = 0;
  double temp3 = 0;
  double temp4 = 0;

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp1 = 0;
        temp2 = 0;
        temp3 = 0;
        temp4 = 0;

        return;
      }

      if (weatherData['name'] == 'Tokyo') {
        var condition1 = weatherData['main']['temp'];
        temp1 = condition1;
      } else if (weatherData['name'] == 'Osaka') {
        var condition2 = weatherData['main']['temp'];
        temp2 = condition2;
      } else if (weatherData['name'] == 'London') {
        var condition3 = weatherData['main']['temp'];
        temp3 = condition3;
      } else if (weatherData['name'] == 'Beijing') {
        var condition4 = weatherData['main']['temp'];
        temp4 = condition4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Get Weather')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  cardChild: IconContent(
                    temp: temp1,
                    label: '東京',
                    onPress: () async {
                      var weatherData = await weather.getCityWeather('tokyo');
                      print(weatherData);
                      updateUI(weatherData);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  cardChild: IconContent(
                    temp: temp2,
                    label: '大阪',
                    onPress: () async {
                      var weatherData = await weather.getCityWeather('osaka');
                      updateUI(weatherData);
                    },
                  ),
                ),
              ),
            ],
          )),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  cardChild: IconContent(
                    temp: temp3,
                    label: 'ロンドン',
                    onPress: () async {
                      var weatherData = await weather.getCityWeather('london');
                      updateUI(weatherData);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  cardChild: IconContent(
                    temp: temp4,
                    label: '北京',
                    onPress: () async {
                      var weatherData = await weather.getCityWeather('beijing');
                      updateUI(weatherData);
                    },
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
