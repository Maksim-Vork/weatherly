import 'package:forecast/features/Weather/data/models/condition_model.dart';
import 'package:forecast/features/Weather/domain/entity/day.dart';

class DayModel {
  final double maxtempC;
  final double mintempC;
  final ConditionModel conditionModel;

  DayModel({
    required this.maxtempC,
    required this.mintempC,
    required this.conditionModel,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      maxtempC: json['maxtemp_c'] ?? 0.0,
      mintempC: json['mintemp_c'] ?? 0.0,
      conditionModel: ConditionModel.fromJson(json['condition']),
    );
  }
  Day toEntity() {
    return Day(
      maxtempC: maxtempC,
      mintempC: mintempC,
      condition: conditionModel.toEntity(),
    );
  }
}
