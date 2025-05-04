import 'package:forecast/features/Weather/domain/entity/weather.dart';

abstract class CurrentWeatherRepository {
  Future<Weather> getCurrentWeather(String city);
}
