import 'package:flutter/material.dart';

import 'package:share/share.dart';

import 'package:flutterweatherapplication/models/models.dart' as model;
import 'package:flutterweatherapplication/widgets/widgets.dart';

class Weather extends StatelessWidget {
  final model.Weather weather;
  final String city;
  final String country;
  final DateTime lastUpdate;

  Weather({
    Key key,
    @required this.weather,
    @required this.city,
    @required this.country,
    @required this.lastUpdate
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
                children: <Widget>[
                  TodaysDate(),
                  CombinedWeatherTemperature(weather: weather),
                  CombinedLocationCondition(
                      city: city,
                      country: country,
                      formattedCondition: weather.formattedCondition
                  ),
                  Divider(),
                  AdditionalWeatherInformation(
                    humidity: weather.humidity,
                    feelsLike: weather.feelsLike,
                    overcast: weather.overcast,
                    precipitation: weather.precipitation,
                    pressure: weather.pressure,
                    windSpeed: weather.windSpeed,
                    windDirection: weather.windDirection,
                  ),
                  Divider(),
                ]
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: (){
                Share.share(weather.weatherToShare);
                },
              label: Text('Share'),
              icon: Icon(Icons.share),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
        )
    );
  }
}
