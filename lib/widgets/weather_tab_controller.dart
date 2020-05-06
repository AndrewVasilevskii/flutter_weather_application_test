import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterweatherapplication/bloc/forecast_bloc.dart';
import 'package:flutterweatherapplication/widgets/widgets.dart';

class WeatherTabController extends StatefulWidget {
  @override
  _WeatherTabControllerState createState() => _WeatherTabControllerState();
}

class _WeatherTabControllerState extends State<WeatherTabController> with
    WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
          title: Text('Weather'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Today'),
              Tab(text: 'Forecast')
            ],
            controller: _tabController
          )
      ),
      body: TabBarView(
        children: <Widget>[
          WeatherToday(),
          Forecast()
        ],
        controller: _tabController
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