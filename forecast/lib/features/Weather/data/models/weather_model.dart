import 'package:forecast/features/Weather/data/models/models.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';

class WeatherModel {
  final String nameCity;
  final CurrentModel current;
  final ForecastModel forecastModel;

  WeatherModel(this.nameCity, this.current, this.forecastModel);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      json['location']['name'],
      CurrentModel.fromJson(json['current']),
      ForecastModel.fromJson(json['forecast']),
    );
  }
  Weather toEntity() {
    return Weather(nameCity, current.toEntity(), forecastModel.toEntity());
  }
}
