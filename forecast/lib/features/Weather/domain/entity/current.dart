import 'package:forecast/features/Weather/domain/entity/condition.dart';

class Current {
  final double temperature;
  final Condition condition;

  Current(this.temperature, this.condition);
}
