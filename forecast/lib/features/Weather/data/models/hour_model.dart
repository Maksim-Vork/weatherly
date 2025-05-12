import 'package:forecast/features/Weather/data/models/condition_model.dart';
import 'package:forecast/features/Weather/domain/entity/hour.dart';

class HourModel {
  final String time;
  final double tempC;
  final ConditionModel conditionModel;

  HourModel({
    required this.time,
    required this.tempC,
    required this.conditionModel,
  });

  factory HourModel.fromJson(Map<String, dynamic> json) {
    return HourModel(
      conditionModel: ConditionModel.fromJson(json['condition']),
      time: json['time'],
      tempC: json['temp_c'] ?? 0.0,
    );
  }
  Hour toEntity() {
    return Hour(
      time: DateTime.parse(time),
      tempC: tempC,
      condition: conditionModel.toEntity(),
    );
  }
}
