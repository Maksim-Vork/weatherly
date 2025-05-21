import 'package:forecast/features/Weather/data/models/models.dart';
import 'package:forecast/features/Weather/domain/entity/forecast.dart';

class ForecastModel {
  final List<ForecastDayModel> forecastDay;

  ForecastModel({required this.forecastDay});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> forecastDaysJson = json['forecastday'];

    return ForecastModel(
      forecastDay:
          forecastDaysJson
              .map((dayJson) => ForecastDayModel.fromJson(dayJson))
              .toList(),
    );
  }
  Forecast toEntity() {
    return Forecast(forecastDay: forecastDay.map((e) => e.toEntity()).toList());
  }
}
