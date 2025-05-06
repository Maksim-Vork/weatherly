import 'package:forecast/features/Weather/data/models/condition_model.dart';

class CurrentModel {
  final double temperature;
  final ConditionModel condition;

  CurrentModel(this.temperature, this.condition);
  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
      json['temp_c']?.toDouble() ?? 0.0,
      ConditionModel.fromJson(json['condition']),
    );
  }
}
