import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import 'package:flutterweatherapplication/models/current_location.dart';
import 'package:flutterweatherapplication/models/forecast.dart';

class WeatherApiClient {
  static const apiKey = '835b831b343db84f6b728e921ba61b6f';
  static const baseUrl = 'http://api.openweathermap.org/data/2.5/forecast';
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient});

  Future<Forecast> fetchWeatherByCityName(CurrentLocation location) async {
    final requestUrl = '$baseUrl?q=${location.city},${location.countryCode}&appid=$apiKey&units=metric';
    final weatherResponse = await httpClient.get(requestUrl);
    if (weatherResponse.statusCode != 200) {
      throw Exception('Error getting weather.');
    }
    final weatherJson = jsonDecode(weatherResponse.body);
    return Forecast.fromJson(weatherJson);
  }
}