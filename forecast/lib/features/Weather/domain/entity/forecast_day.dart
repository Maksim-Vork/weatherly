import 'package:forecast/features/Weather/domain/entity/day.dart';
import 'package:forecast/features/Weather/domain/entity/hour.dart';

class ForecastDay {
  final DateTime data;
  final Day day;
  final List<Hour> hour;

  ForecastDay({required this.data, required this.day, required this.hour});
}
