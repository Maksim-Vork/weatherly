abstract class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {}

class UpdatedWeatherEvent extends WeatherEvent {
  final String nameCity;

  UpdatedWeatherEvent({required this.nameCity});
}
