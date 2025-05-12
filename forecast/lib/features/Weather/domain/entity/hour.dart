import 'package:forecast/features/Weather/domain/entity/condition.dart';

class Hour {
  final DateTime time;
  final double tempC;
  final Condition condition;

  Hour({required this.time, required this.tempC, required this.condition});
}
