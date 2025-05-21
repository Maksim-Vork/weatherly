import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:forecast/features/Weather/domain/repository/current_weather_repository.dart';

class GetCurrentWeatherUsecase {
  final WeatherRepository repository;

  GetCurrentWeatherUsecase(this.repository);

  Future<Weather> call(String city) async {
    final Weather weather = await repository.getCurrentWeather(city);

    return weather;
  }
}
