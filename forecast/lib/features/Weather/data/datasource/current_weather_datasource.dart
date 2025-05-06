import 'package:forecast/core/dio_service.dart';
import 'package:forecast/features/Weather/data/models/weather_model.dart';

class CurrentWeatherDatasource {
  late final DioService dioService;

  CurrentWeatherDatasource(this.dioService);

  Future<WeatherModel> getCurrentWeather(String city) async {
    try {
      final response = await dioService.get(
        '/v1/forecast.json',
        queryParams: {
          'key': '6c9aa680e7e54dbdaf1133755250105',
          'q': city,
          'lang': 'ru',
          'days': 7,
        },
      );
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      final WeatherModel result = WeatherModel.fromJson(json);
      return result;
    } catch (e) {
      print(e);
      throw Exception('Не удалось получить погоду');
    }
  }
}
