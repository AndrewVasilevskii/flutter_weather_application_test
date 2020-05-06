import 'dart:io';

import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

import 'package:flutterweatherapplication/models/forecast.dart';
import 'package:flutterweatherapplication/repositories/weather_repository.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object> get props => [];
}

class FetchForecast extends ForecastEvent {
  const FetchForecast();
}

class RefreshForecast extends ForecastEvent {
  const RefreshForecast();
}

abstract class ForecastState extends Equatable {
  const ForecastState();
  @override
  List<Object> get props => [];
}

class ForecastEmpty extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastLoaded extends ForecastState {
  final Forecast forecast;
  const ForecastLoaded({@required this.forecast});

  @override
  List<Object> get props => [forecast];
}

class ForecastError extends ForecastState {
  final Exception exception;
  const ForecastError({@required this.exception});

  @override
  List<Object> get props => [exception];
}

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final WeatherRepository weatherRepository;

  ForecastBloc({@required this.weatherRepository});

  @override
  ForecastState get initialState => ForecastEmpty();

  @override
  Stream<ForecastState> mapEventToState(ForecastEvent event) async* {
    if (event is FetchForecast) {
      yield* _mapFetchForecastToState(event);
    }
    if (event is RefreshForecast) {
      yield* _mapRefreshForecastToState(event);
    }
  }

  Stream<ForecastState> _mapFetchForecastToState(FetchForecast event) async* {
    yield ForecastLoading();
    final connect = await Connectivity().checkConnectivity();
    if (connect == ConnectivityResult.mobile || connect == ConnectivityResult.wifi){
      try {
        final Forecast forecast  = await weatherRepository.fetchForecast();
        await weatherRepository.saveForecastToDatabase(forecast);
        yield ForecastLoaded(forecast: forecast);
      } on HttpException {
        yield ForecastError(exception: HttpException('Error reciving data.'));
        yield* _mapLoadFromDatabaseForecastToState(event);
      } catch(e) {
        yield ForecastError(exception: e);
      }
    } else {
      yield ForecastError(exception: SocketException('No internet connection.'));
      yield* _mapLoadFromDatabaseForecastToState(event);
    }
  }

  Stream<ForecastState> _mapLoadFromDatabaseForecastToState(ForecastEvent event) async* {
    yield ForecastLoading();
    try {
      final Forecast forecast = await weatherRepository.loadForecastFromDatabase();
      yield ForecastLoaded(forecast: forecast);
    } catch (_) {
      yield ForecastError(exception: FileSystemException('No data.'));
    }
  }

  Stream<ForecastState> _mapRefreshForecastToState(RefreshForecast event) async* {
    final connect = await Connectivity().checkConnectivity();
    if (connect == ConnectivityResult.mobile || connect == ConnectivityResult.wifi){
      try {
        final Forecast forecast  = await weatherRepository.fetchForecast();
        await weatherRepository.saveForecastToDatabase(forecast);
        yield ForecastLoaded(forecast: forecast);
      } on HttpException {
        yield ForecastError(exception: HttpException('Error reciving data.'));
        yield* _mapLoadFromDatabaseForecastToState(event);
      } catch (e) {
        yield ForecastError(exception: e);
      }
    } else {
      yield* _mapLoadFromDatabaseForecastToState(event);
    }
  }
}
