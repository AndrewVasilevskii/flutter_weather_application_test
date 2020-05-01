import 'package:equatable/equatable.dart';

import 'package:flutterweatherapplication/models/weather.dart';

class Forecast extends Equatable{
  final List<Weather> forecast;
  final String city;
  final String country;
  final DateTime lastUpdate;

  Forecast({this.forecast,
            this.city,
            this.country,
            this.lastUpdate});

  @override
  List<Object> get props => [
    forecast,
    city,
    country,
    lastUpdate
  ];

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecast: List<Weather>.from(json['list'].map((x) => Weather.fromJson(x))),
    city: json['city']['name'],
    country: json['city']['country'],
    lastUpdate: DateTime.now()
  );
}