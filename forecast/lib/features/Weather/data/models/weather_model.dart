class WeatherModel {
  final double temperature;

  WeatherModel(this.temperature);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(json['current']['temp_c']?.toDouble() ?? 0.0);
  }
}
