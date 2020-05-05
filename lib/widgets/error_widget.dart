import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterweatherapplication/bloc/forecast_bloc.dart';

class MyErrorWidget extends StatelessWidget {
  final String message;

  MyErrorWidget({Key key, @required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message),
          FlatButton(
              onPressed: () {
                BlocProvider.of<ForecastBloc>(context).add(FetchForecast());
                },
              child: Text('Try to reload.',
                  style: TextStyle(
                      decoration: TextDecoration.underline
                  )
              )
          )
        ]
    );
  }
}