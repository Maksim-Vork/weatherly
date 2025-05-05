import 'package:forecast/features/Weather/data/repository/weather_repository_impl.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';

class GetCurrentWeatherUsecase {
  final WeatherRepositoryImpl repository;

  GetCurrentWeatherUsecase(this.repository);

  Future<Weather> call(String city) async {
    final Weather weather = await repository.getCurrentWeather(city);

    return weather;
  }
}
