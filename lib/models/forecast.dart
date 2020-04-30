
import 'package:flutterweatherapplication/models/weather.dart';

class Forecast {
  final List<Weather> forecast;
  final String city;
  final String country;
  final DateTime lastUpdate;

  Forecast({this.forecast,
            this.city,
            this.country,
            this.lastUpdate});

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecast: List<Weather>.from(json['list'].map((x) => Weather.fromJson(x))),
    city: json['city']['name'],
    country: json['city']['name'],
    lastUpdate: DateTime.now()
  );
}