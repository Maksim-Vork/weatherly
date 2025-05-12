import 'package:forecast/features/Weather/domain/entity/current.dart';
import 'package:forecast/features/Weather/domain/entity/forecast.dart';

class Weather {
  final String nameCity;
  final Current current;
  final Forecast forecast;

  Weather(this.nameCity, this.current, this.forecast);
}
