import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherapplication/bloc/forecast_bloc.dart';

import 'package:intl/intl.dart';

import 'package:flutterweatherapplication/models/models.dart' as model;
import 'package:flutterweatherapplication/widgets/widgets.dart';

class Forecast extends StatefulWidget {
  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForecastBloc, ForecastState>(
        listener: (context, state){
          if (state is ForecastLoaded){
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is ForecastLoaded) {
            final forecast = state.forecast;
            final forecastWithHeaders = _mapForecastToTableItems(
                forecast.forecast
            );
            return RefreshIndicator(onRefresh: () {
              BlocProvider.of<ForecastBloc>(context).add(RefreshForecast());
              return _refreshCompleter.future;
              },
                child: ListView.builder(
                    itemCount: forecastWithHeaders.length,
                    itemBuilder: (context, index) {
                      final item = forecastWithHeaders[index];

                      return ListTile(leading: item.buildLeading(context),
                        title: item.buildTitle(context),
                        subtitle: item.buildSubTitle(context),
                        trailing: item.buildTrailing(context),
                      );
                    })
            );
          }
          if (state is ForecastError) {
            return Center(child: Text("Error loading Forecast."));
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  List<dynamic> _mapForecastToTableItems(List<model.Weather> input) {
    if (input.length != 0) {
      final newList = [];
      final date = input[0].weatherAt;
      final formattedDate = mapDateToFormat(date);
      newList.add(HeadingItem(heading: date));
      newList.addAll(
          (input.takeWhile((item) => mapDateToFormat(item.weatherAt) == formattedDate))
          .map((item) => WeatherItem(weather: item))
      );
      newList.addAll(
          _mapForecastToTableItems(
              (input.skipWhile((item) => mapDateToFormat(item.weatherAt) == formattedDate))
                  .toList()
          )
      );
      return newList;
    }
    return [];
  }

}

String mapDateToFormat(DateTime date) {
  return DateFormat('yMd').format(date);
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildSubTitle(BuildContext context);

  Widget buildLeading(BuildContext context);

  Widget buildTrailing(BuildContext context);
}

class HeadingItem implements ListItem {
  final DateTime heading;

  HeadingItem({this.heading});

  @override
  Widget buildTitle(BuildContext context) {
    if (mapDateToFormat(heading) == mapDateToFormat(DateTime.now())) {
      return Text('Today',
          style: TextStyle(fontSize: 18)
      );
    }
    return Text(DateFormat('EEEE').format(heading),
        style: TextStyle(fontSize: 18)
    );
  }

  @override
  Widget buildLeading(BuildContext context) => null;

  @override
  Widget buildSubTitle(BuildContext context) => null;

  @override
  Widget buildTrailing(BuildContext context) => null;
}

class WeatherItem implements ListItem {
  final model.Weather weather;

  WeatherItem({this.weather});

  @override
  Widget buildLeading(BuildContext context) {
    return WeatherConditions(
      condition: weather.condition,
      dateTime: weather.weatherAt);
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Text(DateFormat.jm().format(weather.weatherAt));
  }

  @override
  Widget buildSubTitle(BuildContext context) {
    return Text(weather.formattedCondition);
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return Text('${weather.temperature}\u00B0',
        style: TextStyle(fontSize: 35)
    );
  }

}