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
    return Scaffold(
        backgroundColor:Colors.transparent,
        appBar: AppBar(
            title: Text("Weather",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                )
            ),
          backgroundColor: Colors.white
        ),
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
          icon: Icon(Icons.share)),
    );
  }
}
