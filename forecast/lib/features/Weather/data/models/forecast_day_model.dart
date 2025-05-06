import 'package:forecast/features/Weather/data/models/day_model.dart';
import 'package:forecast/features/Weather/data/models/hour_model.dart';

class ForecastDayModel {
  final String data; // в сущносте сделать тип data
  final DayModel dayModel;
  final List<HourModel> hourModels;

  ForecastDayModel({
    required this.data,
    required this.dayModel,
    required this.hourModels,
  });
}
