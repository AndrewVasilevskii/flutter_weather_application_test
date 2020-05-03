import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterweatherapplication/bloc/forecast_bloc.dart';
import 'package:flutterweatherapplication/widgets/widgets.dart';

class WeatherToday extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForecastBloc, ForecastState>(
        listener: (context, state) {
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
            return Weather(
              weather: forecast.forecast[0],
              city: forecast.city,
              country: forecast.country,
              lastUpdate: forecast.lastUpdate,
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