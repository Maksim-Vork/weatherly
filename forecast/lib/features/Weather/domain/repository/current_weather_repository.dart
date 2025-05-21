import 'package:forecast/features/Weather/domain/entity/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String city);
}
