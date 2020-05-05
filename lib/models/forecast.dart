import 'package:equatable/equatable.dart';

import 'package:flutterweatherapplication/models/weather.dart';

class Forecast extends Equatable{
  final List<Weather> forecast;
  final String city;
  final String country;
  final int sunrise;
  final int sunset;
  final DateTime lastUpdate;

  Forecast({
    this.forecast,
    this.city,
    this.country,
    this.sunrise,
    this.sunset,
    this.lastUpdate
  });

  @override
  List<Object> get props => [
    forecast,
    city,
    country,
    sunrise,
    sunset,
    lastUpdate
  ];

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecast: List<Weather>.from(json['list'].map((x) => Weather.fromJson(x))),
    city: json['city']['name'],
    country: json['city']['country'],
    sunrise: json['city']['sunrise'],
    sunset: json['city']['sunset'],
    lastUpdate: DateTime.now()
  );

  factory Forecast.fromDatabase(Map<String, dynamic> json, List<Weather> weather) =>
  Forecast(
    forecast: weather,
    city: json['city'],
    country: json['country'],
    sunrise: json['sunrise'],
    sunset:  json['sunset'],
    lastUpdate: json['lastUpdate']
  );

  Map<String, dynamic> toDatabase() => {
    'city': city,
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset
  };
}