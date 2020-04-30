
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

class Weather {
  final double temperature;
  final double temperatureMin;
  final double temperatureMax;
  final int pressure;
  final int humidity;
  final int rainVolume;
  final int snowVolume;
  final String name;
  final String description;
  final WeatherCondition weatherCondition;
  final double windSpeed;
  final String windDirection;
  final DateTime weatherAt;

  Weather({
          this.temperature,
          this.temperatureMin,
          this.temperatureMax,
          this.pressure,
          this.humidity,
          this.rainVolume,
          this.snowVolume,
          this.name,
          this.description,
          this.weatherCondition,
          this.windSpeed,
          this.windDirection,
          this.weatherAt
      });

  factory Weather.fromJson(Map<String, dynamic> json) {
    var rainVolume;
    var snowVolume;
    try {
      snowVolume = json['snow']['3h'];
      rainVolume = json['rain']['3h'];
    } catch (error) {}
    return Weather(
        temperature: json['main']['temp'].toDouble(),
        temperatureMin: json['main']['temp_min'].toDouble(),
        temperatureMax: json['main']['temp_max'].toDouble(),
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
        rainVolume: rainVolume ?? 0,
        snowVolume: snowVolume ?? 0,
        name: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        weatherCondition: _mapStringToWeatherCondition(
            json['weather'][0]['description']),
        windSpeed: json['wind']['speed'].toDouble(),
        windDirection: _mapDegreesToDirection(json['wind']['deg'].toDouble()),
        weatherAt: DateTime.parse(json['dt_txt'])
    );
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