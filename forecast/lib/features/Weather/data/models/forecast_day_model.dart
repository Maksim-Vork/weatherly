import 'package:forecast/features/Weather/data/models/models.dart';
import 'package:forecast/features/Weather/domain/entity/forecast_day.dart';

class ForecastDayModel {
  final String data;
  final DayModel dayModel;
  final List<HourModel> hourModels;

  ForecastDayModel({
    required this.data,
    required this.dayModel,
    required this.hourModels,
  });

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> hourJson = json['hour'];

    return ForecastDayModel(
      data: json['date'],
      dayModel: DayModel.fromJson(json['day']),
      hourModels:
          hourJson.map((hourJson) => HourModel.fromJson(hourJson)).toList(),
    );
  }
  ForecastDay toEntity() {
    return ForecastDay(
      data: DateTime.parse(data),
      day: dayModel.toEntity(),
      hour: hourModels.map((e) => e.toEntity()).toList(),
    );
  }
}
