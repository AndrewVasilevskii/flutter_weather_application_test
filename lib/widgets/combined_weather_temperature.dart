import 'package:flutter/material.dart';

import 'package:flutterweatherapplication/models/models.dart' as model;
import 'package:flutterweatherapplication/widgets/widgets.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  final model.Weather weather;

  CombinedWeatherTemperature({Key key, @required this.weather}):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: WeatherConditions(
                      condition: weather.condition,
                      dateTime: DateTime.now()
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text('${weather.temperature}',
                    style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w300,
                    )
                )
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child:Text('\u2103',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                        )
                    )
                )
            ),
          ],
        ));
  }
}