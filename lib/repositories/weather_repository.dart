import 'package:flutterweatherapplication/clients/clients.dart';
import 'package:flutterweatherapplication/models/forecast.dart';

class WeatherRepository {
  final LocationApiClient locationApiClient;
  final WeatherApiClient weatherApiClient;

  WeatherRepository({
    this.locationApiClient,
    this.weatherApiClient
  });

  Future<Forecast> fetchForecast() async {
    final location = await locationApiClient.getLocation();
    return weatherApiClient.fetchWeatherByCityName(location);
  }

  Future<Forecast> loadForecastFromDatabase() async {
    return DatabaseClient.db.getForecast();
  }

  Future saveForecastToDatabase(Forecast forecast) async {
    DatabaseClient.db.newForecast(forecast);
  }
}