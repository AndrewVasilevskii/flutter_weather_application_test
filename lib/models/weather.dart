import 'dart:math';

import 'package:equatable/equatable.dart';

import 'package:flutterweatherapplication/models/weather_condition_descriptions.dart' as desc;

enum WeatherCondition {
  clear,
  fewClouds,
  scatterClouds,
  brokenClouds,
  showerRain,
  freezingRain,
  rain,
  thunderstorm,
  show,
  mist,
  unknown
}

class Weather extends Equatable {
  final int temperature;
  final int pressure;
  final int humidity;
  final int precipitation;
  final String formattedCondition;
  final WeatherCondition condition;
  final double windSpeed;
  final String windDirection;
  final DateTime weatherAt;

  String get weatherToShare {
    return 'Today: $formattedCondition with $humidity% humidity and '
        '$precipitation mm precipitation.'
        '\n$windDirection wind with ${(windSpeed*3.6).toStringAsFixed(1)} km/h.'
        '\nIt\'s $temperature \u2103.';
  }

  Weather({
          this.temperature,
          this.pressure,
          this.humidity,
          this.precipitation,
          this.formattedCondition,
          this.condition,
          this.windSpeed,
          this.windDirection,
          this.weatherAt
      });

  @override
  List<Object> get props => [
        temperature,
        pressure,
        humidity,
        precipitation,
        formattedCondition,
        condition,
        windSpeed,
        windDirection,
        weatherAt
      ];

  factory Weather.fromJson(Map<String, dynamic> json) {
    var rainVolume;
    var snowVolume;
    try {
      snowVolume = json['snow']['3h'];
      rainVolume = json['rain']['3h'];
    } catch (error) {}

    return Weather(
        temperature: (json['main']['temp'].toDouble()).round(),
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
        precipitation: max(rainVolume ?? 0, snowVolume ?? 0),
        formattedCondition: _toBeginningOfSentenceCase(json['weather'][0]['description']),
        condition: _mapStringToWeatherCondition(
            json['weather'][0]['description']),
        windSpeed: json['wind']['speed'].toDouble(),
        windDirection: _mapDegreesToDirection(json['wind']['deg'].toDouble()),
        weatherAt: DateTime.parse(json['dt_txt'])
    );
  }

  static String _toBeginningOfSentenceCase(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    if (desc.clearSky.contains(input)) {
      state = WeatherCondition.clear;
    } else if (desc.fewClouds.contains(input)) {
      state = WeatherCondition.fewClouds;
    } else if (desc.scatterClouds.contains(input)) {
      state = WeatherCondition.scatterClouds;
    } else if (desc.brokenClouds.contains(input)) {
      state = WeatherCondition.brokenClouds;
    } else if (desc.mist.contains(input)) {
      state = WeatherCondition.mist;
    } else if (desc.snow.contains(input)) {
      state = WeatherCondition.show;
    } else if (desc.rain.contains(input)) {
      state = WeatherCondition.rain;
    } else if (desc.freezingRain.contains(input)) {
      state = WeatherCondition.freezingRain;
    } else if (desc.showerRain.contains(input)) {
      state = WeatherCondition.showerRain;
    } else if (desc.thunderstorm.contains(input)) {
      state = WeatherCondition.thunderstorm;
    } else {
      state = WeatherCondition.unknown;
    }

    return state;
  }

  static String _mapDegreesToDirection(double input) {
    String direction;
    if (input >= 337.5 || input <= 22.5) {
      direction = 'N';
    } else if (input > 22.5 && input < 67.5) {
      direction = 'NE';
    } else if (input >= 67.5 && input <= 112.5) {
      direction = 'E';
    } else if (input > 112.5 && input < 157.5) {
      direction = 'SE';
    } else if (input >= 157.5 && input < 202.5) {
      direction = 'S';
    } else if (input > 202.5 && input < 247.5) {
      direction = 'SW';
    } else if (input >= 247.5 && input <= 292.5) {
      direction = 'W';
    } else if (input > 292.5 && input < 337.5) {
      direction = 'NW';
    }
    return direction;
  }
}