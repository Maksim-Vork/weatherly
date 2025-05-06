import 'package:forecast/features/Weather/data/models/condition_model.dart';

class DayModel {
  final double maxtempC;
  final double mintempC;
  final ConditionModel conditionModel;

  DayModel({
    required this.maxtempC,
    required this.mintempC,
    required this.conditionModel,
  });
}
