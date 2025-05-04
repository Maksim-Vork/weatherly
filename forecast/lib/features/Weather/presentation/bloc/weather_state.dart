import 'package:forecast/features/Weather/domain/entity/weather.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded(this.weather);
}

class WeatherError extends WeatherState {
  final String error;

  WeatherError(this.error);
}
