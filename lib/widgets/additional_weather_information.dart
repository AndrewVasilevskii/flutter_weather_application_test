import 'package:flutter/material.dart';

class AdditionalWeatherInformation extends StatelessWidget {
  final int humidity;
  final int feelsLike;
  final int overcast;
  final num precipitation;
  final int pressure;
  final double windSpeed;
  final String windDirection;

  String get humidityInfo {
    return '$humidity%';
  }

  String get feelsLikeInfo {
    return '$feelsLike\u00B0';
  }

  String get overcastInfo {
    return '$overcast%';
  }

  String get precipitationInfo {
    return '$precipitation mm';
  }

  String get pressureInfo {
    return '$pressure hPa';
  }

  String get windInfo {
    return '$windDirection ${(windSpeed*3.6).toStringAsFixed(1)} km/h';
  }

  AdditionalWeatherInformation({
    Key key,
    @required this.humidity,
    @required this.feelsLike,
    @required this.overcast,
    @required this.precipitation,
    @required this.pressure,
    @required this.windSpeed,
    @required this.windDirection
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(
              width: 1,
              color: Colors.grey.withOpacity(0.4)
          ),
        ),
        children: [
          TableRow(children: [
            _cellFor(title: 'HUMIDITY', info: humidityInfo),
            _cellFor(title: 'PRECIPITATION', info: precipitationInfo)
          ]),
          TableRow(children: [
            _cellFor(title: 'WIND', info: windInfo),
            _cellFor(title: 'FEELS LIKE', info: feelsLikeInfo)
          ]),
          TableRow(children: [
            _cellFor(title: 'OVERCAST', info: overcastInfo),
            _cellFor(title: 'PRESSURE', info: pressureInfo)
          ])
        ],
      )
    );
  }

  TableCell _cellFor({String title, String info}) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w300
                )
            ),
            Text(info,
                style: TextStyle(fontSize: 17))
          ],
        ),
      )
    );
  }
}