import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_delegate.dart';
import 'package:flutterweatherapplication/bloc/forecast_bloc.dart';
import 'package:flutterweatherapplication/clients/clients.dart';
import 'package:flutterweatherapplication/repositories/weather_repository.dart';
import 'package:flutterweatherapplication/widgets/widgets.dart';

void main() {

  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    locationApiClient: LocationApiClient(),
    weatherApiClient: WeatherApiClient(httpClient: http.Client())
  );

  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository}):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          appBarTheme: AppBarTheme(
              brightness: Brightness.light,
          )
      ),
      darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(create: (context) =>
            ForecastBloc(weatherRepository: weatherRepository),
            child: WeatherTabController()
        )
    );
  }
}
