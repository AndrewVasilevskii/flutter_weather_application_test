import 'package:flutter/material.dart';

class CombinedLocationCondition extends StatelessWidget {
  final String city;
  final String country;
  final String formattedCondition;

  CombinedLocationCondition({
    Key key,
    @required this.city,
    @required this.country,
    @required this.formattedCondition
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(formattedCondition,
                style: TextStyle(
                    fontSize: 25
                )
            )
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.near_me,
                      color: Colors.green,
                      size: 20
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child:Text('$city, $country')),
            Spacer()
          ],
        )
      ],
    );
  }
}