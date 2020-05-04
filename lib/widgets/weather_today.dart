import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterweatherapplication/bloc/forecast_bloc.dart';
import 'package:flutterweatherapplication/widgets/widgets.dart';

class WeatherToday extends StatefulWidget {
  @override
  _WeatherTodayState createState() => _WeatherTodayState();
}

class _WeatherTodayState extends State<WeatherToday> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForecastBloc, ForecastState>(
        listener: (context, state) {
          if (state is ForecastLoaded) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
          if (state is ForecastError) {
            Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error."),
                  backgroundColor: Colors.redAccent,
                )
            );
          }
          },
        builder: (context, state) {
          if (state is ForecastLoaded) {
            final forecast = state.forecast;
            return RefreshIndicator(
                onRefresh: () {
                  BlocProvider.of<ForecastBloc>(context).add(
                    RefreshForecast(),
                  );
                  return _refreshCompleter.future;
                  },
                child: Weather(
                  weather: forecast.forecast[0],
                  city: forecast.city,
                  country: forecast.country,
                  lastUpdate: forecast.lastUpdate,
                )
            );
          }
          if (state is ForecastError) {
            return Center(child: Text('Error appeared'));
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }
}