import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutterweatherapplication/models/models.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;
  final DateTime dateTime;
  final baseDirectory = 'assets/condition_images';

  WeatherConditions({
    Key key,
    @required this.condition,
    @required this.dateTime
  }): super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage();

  Image _mapConditionToImage() {
    var dayOrNight = '';
    final hour = int.parse(DateFormat('kk').format(dateTime));
    if (hour >= 7 && hour < 20) {
      dayOrNight = 'day';
    } else {
      dayOrNight = 'night';
    }
    Image image;
    switch (condition){
      case WeatherCondition.clear:
        image = Image.asset('$baseDirectory/clear_$dayOrNight.png');
        break;
      case WeatherCondition.fewClouds:
        image = Image.asset('$baseDirectory/few_clouds_$dayOrNight.png');
        break;
      case WeatherCondition.scatterClouds:
        image = Image.asset('$baseDirectory/scatter_clouds.png');
        break;
      case WeatherCondition.brokenClouds:
        image = Image.asset('$baseDirectory/broken_clouds.png');
        break;
      case WeatherCondition.showerRain:
        image = Image.asset('$baseDirectory/shower_rain.png');
        break;
      case WeatherCondition.freezingRain:
        image = Image.asset('$baseDirectory/freezing_raint_$dayOrNight.png');
        break;
      case WeatherCondition.rain:
        image = Image.asset('$baseDirectory/rain_$dayOrNight.png');
        break;
      case WeatherCondition.thunderstorm:
        image = Image.asset('$baseDirectory/thunderstorm.png');
        break;
      case WeatherCondition.show:
        image = Image.asset('$baseDirectory/snow.png');
        break;
      case WeatherCondition.mist:
        image = Image.asset('$baseDirectory/mist.png');
        break;
      case WeatherCondition.unknown:
        image = Image.asset('$baseDirectory/clear_$dayOrNight.png');
        break;
    }
    return image;
  }
}