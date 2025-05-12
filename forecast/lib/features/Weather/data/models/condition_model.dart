import 'package:forecast/features/Weather/domain/entity/condition.dart';

class ConditionModel {
  final String icon;

  ConditionModel({required this.icon});

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(icon: json['icon']);
  }

  Condition toEntity() {
    return Condition(icon: icon);
  }
}
