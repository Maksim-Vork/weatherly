import 'package:forecast/features/Weather/data/models/models.dart';
import 'package:forecast/features/Weather/domain/entity/current.dart';

class CurrentModel {
  final double temperature;
  final ConditionModel condition;

  CurrentModel(this.temperature, this.condition);
  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
      json['temp_c'].toDouble() ?? 0.0,
      ConditionModel.fromJson(json['condition']),
    );
  }
  Current toEntity() {
    return Current(temperature, condition.toEntity());
  }
}
