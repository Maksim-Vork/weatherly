import 'package:forecast/features/Weather/data/datasource/current_weather_datasource.dart';
import 'package:forecast/features/Weather/data/models/weather_model.dart';

import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:forecast/features/Weather/domain/repository/current_weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final CurrentWeatherDatasource currentWeatherDatasource;

  WeatherRepositoryImpl(this.currentWeatherDatasource);
  @override
  Future<Weather> getCurrentWeather(String city) async {
    final WeatherModel weather = await currentWeatherDatasource
        .getCurrentWeather(city);
    return weather.toEntity();
  }
}
