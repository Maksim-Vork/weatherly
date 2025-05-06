import 'package:forecast/features/Weather/data/models/condition_model.dart';

class HourModel {
  final String time; // в сущносте сделать тип data
  final double tempC;
  final ConditionModel conditionModel;

  HourModel({
    required this.time,
    required this.tempC,
    required this.conditionModel,
  });
}
