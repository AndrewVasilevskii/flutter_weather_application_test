import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterweatherapplication/bloc/forecast_bloc.dart';
import 'package:flutterweatherapplication/widgets/widgets.dart';

class WeatherPageController extends StatefulWidget {
  @override
  _WeatherPageControllerState createState() => _WeatherPageControllerState();
}

class _WeatherPageControllerState extends State<WeatherPageController> with
    WidgetsBindingObserver {
  int _currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    BlocProvider.of<ForecastBloc>(context).add(FetchForecast());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPage,
          onTap: (index) {
            this._pageController.animateToPage(
                index, duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: new Icon(Icons.wb_sunny),
                title: new Text("Today")),
            BottomNavigationBarItem(
                icon: new Icon(Icons.calendar_today),
                title: new Text("Forecast")),
          ]
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newPage){
          setState(() {
            this._currentPage = newPage;
          });
        },
        children: <Widget>[
          WeatherToday(),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed){
      BlocProvider.of<ForecastBloc>(context).add(FetchForecast());
    }
    super.didChangeAppLifecycleState(state);
  }
}