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
  final int feelsLike;
  final int pressure;
  final int humidity;
  final int overcast;
  final num precipitation;
  final String formattedCondition;
  final WeatherCondition condition;
  final double windSpeed;
  final double windDegree;
  final DateTime weatherAt;

  String get weatherToShare {
    return 'Today: $formattedCondition with $humidity% humidity and '
        '$precipitation mm precipitation.'
        '\n$windDirection wind with '
        '${(windSpeed*3.6).toStringAsFixed(1)} km/h.'
        '\nIt\'s $temperature \u2103.';
  }

  String get windDirection {
    return _mapDegreesToDirection(windDegree);
  }

  Weather({
    this.temperature,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.overcast,
    this.precipitation,
    this.formattedCondition,
    this.condition,
    this.windSpeed,
    this.windDegree,
    this.weatherAt
      });

  @override
  List<Object> get props => [
    temperature,
    feelsLike,
    pressure,
    humidity,
    overcast,
    precipitation,
    formattedCondition,
    condition,
    windSpeed,
    windDegree,
    weatherAt
  ];

  factory Weather.fromJson(Map<String, dynamic> json) {
    var rainVolume;
    var snowVolume;
    try {
      rainVolume = json['rain']['3h'];
    } catch (error) {}
    try {
      snowVolume = json['snow']['3h'];
    } catch (error) {}

    return Weather(
        temperature: (json['main']['temp'].toDouble()).round(),
        feelsLike: (json['main']['feels_like'].toDouble()).round(),
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
        overcast: json['clouds']['all'],
        precipitation: max(rainVolume ?? 0, snowVolume ?? 0),
        formattedCondition: _toBeginningOfSentenceCase(json['weather'][0]['description']),
        condition: _mapStringToWeatherCondition(
            json['weather'][0]['description']),
        windSpeed: json['wind']['speed'].toDouble(),
        windDegree: json['wind']['deg'].toDouble(),
        weatherAt: DateTime.fromMillisecondsSinceEpoch(json['dt']*1000)
    );
  }

  factory Weather.fromDatabase(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'],
      feelsLike: json['feels_like'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      overcast: json['overcast'],
      precipitation: json['precipitation'] % 1 == 0 ? json['precipitation'].toInt() : json['precipitation'],
      formattedCondition: json['formatted_condition'],
      condition: _mapStringToWeatherCondition(json['formatted_condition']),
      windSpeed: json['wind_speed'].toDouble(),
      windDegree: json['wind_degree'].toDouble(),
      weatherAt: DateTime.fromMillisecondsSinceEpoch(json['weather_at']*1000)
    );
  }

  Map<String, dynamic> toDatabase() => {
    'temperature': temperature,
    'feels_like': feelsLike,
    'pressure': pressure,
    'humidity': humidity,
    'overcast': overcast,
    'precipitation': precipitation,
    'formatted_condition': formattedCondition,
    'wind_speed': windSpeed,
    'wind_degree': windDegree,
    'weather_at': weatherAt.millisecondsSinceEpoch~/1000
  };

  static String _toBeginningOfSentenceCase(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    input = input.toLowerCase();
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
    if (input >= 348.75 || input <= 11.25) {
      direction = 'N';
    } else if (input > 11.25 && input < 33.75) {
      direction = 'NNE';
    } else if (input >= 33.75 && input <= 56.25) {
      direction = 'NE';
    } else if (input > 56.25 && input < 78.75) {
      direction = 'ENE';
    } else if (input >= 78.75 && input <= 101.25) {
      direction = 'E';
    } else if (input > 101.25 && input < 123.75) {
      direction = 'ESE';
    } else if (input >= 123.75 && input <= 146.25) {
      direction = 'SE';
    } else if (input > 146.25 && input < 168.75) {
      direction = 'SSE';
    } else if (input >= 168.75 && input <= 191.25) {
      direction = 'S';
    } else if (input > 191.25 && input < 213.75) {
      direction = 'SSW';
    } else if (input >= 213.75 && input <= 236.25) {
      direction = 'SW';
    } else if (input > 236.25 && input < 258.75) {
      direction = 'WSW';
    } else if (input >= 258.75 && input <= 281.25) {
      direction = 'W';
    } else if (input > 281.25 && input < 303.75) {
      direction = 'WNW';
    } else if (input >= 303.75 && input <= 326.25) {
      direction = 'NW';
    } else if (input > 326.25 && input < 348.75) {
      direction = 'NNW';
    }
    return direction;
  }
}