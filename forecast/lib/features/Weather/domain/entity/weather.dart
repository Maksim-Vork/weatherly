import 'package:forecast/features/Weather/domain/entity/current.dart';

class Weather {
  final String nameCity;
  final Current current;

  Weather(this.nameCity, this.current);
}
