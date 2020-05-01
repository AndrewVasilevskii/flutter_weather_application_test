import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutterweatherapplication/models/forecast.dart';
import 'package:flutterweatherapplication/repositories/weather_repository.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class FetchForecast extends ForecastEvent {
  const FetchForecast();

  @override
  List<Object> get props => [];
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

class ForecastError extends ForecastState {}

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final WeatherRepository weatherRepository;

  ForecastBloc({@required this.weatherRepository});

  @override
  ForecastState get initialState => ForecastEmpty();

  @override
  Stream<ForecastState> mapEventToState(ForecastEvent event) async* {
    if (event is FetchForecast) {
      yield* _mapFeatchForecastToState(event);
    }
  }

  @override
  Stream<ForecastState> _mapFeatchForecastToState(FetchForecast event) async* {
    yield ForecastLoading();
    try {
      final Forecast forecast  = await weatherRepository.getWeather();
      yield ForecastLoaded(forecast: forecast);
    } catch (_) {
      yield ForecastError();
    }
  }
}