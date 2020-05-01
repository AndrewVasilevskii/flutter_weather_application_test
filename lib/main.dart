import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_delegate.dart';
import 'package:flutterweatherapplication/api_clients/location_api_client.dart';
import 'package:flutterweatherapplication/api_clients/weather_api_client.dart';
import 'package:flutterweatherapplication/repositories/weather_repository.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final WeatherRepository weatherRepository = WeatherRepository(
    locationApiClient: LocationApiClient(),
    weatherApiClient: WeatherApiClient(httpClient: http.Client())
  );
}
