

import 'package:flutterweatherapplication/api_clients/location_api_client.dart';
import 'package:flutterweatherapplication/api_clients/weather_api_client.dart';
import 'package:flutterweatherapplication/models/forecast.dart';

class WeatherRepository {
  final LocationApiClient locationApiClient;
  final WeatherApiClient weatherApiClient;

  WeatherRepository({this.locationApiClient, this.weatherApiClient});

  Future<Forecast> getWeather() async {
    final location = await locationApiClient.getLocation();
    return weatherApiClient.fetchWeatherByCoordinates(location);
  }
}