import 'package:forecast/features/Weather/data/models/forecast_day_model.dart';

class ForecastModel {
  final List<ForecastDayModel> forecastDay;

  ForecastModel({required this.forecastDay});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> forecastDaysJson = json['forecast']['forecastday'];

    return ForecastModel(
      forecastDay:
          forecastDaysJson
              .map((dayJson) => ForecastDayModel.fromJson(dayJson))
              .toList(),
    );
  }
}
