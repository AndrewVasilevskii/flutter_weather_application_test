import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TodaysDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
        child: Column(
          children: <Widget>[
            Text('Today',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23)
            ),
            Text('${DateFormat('EEE, d MMM').format(DateTime.now())}')
          ],
        )
    );
  }
}