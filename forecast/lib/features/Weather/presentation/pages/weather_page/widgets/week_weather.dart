import 'package:flutter/material.dart';
import 'package:forecast/features/Weather/domain/entity/forecast_day.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';

import 'package:intl/intl.dart';

class WeekWeather extends StatelessWidget {
  final Weather weather;
  const WeekWeather({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final List<ForecastDay> listForecast = weather.forecast.forecastDay;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            child: Column(
              children: List.generate(
                weather.forecast.forecastDay.length,
                (index) =>
                    WeatherForecastWeek(forecastDay: listForecast[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherForecastWeek extends StatelessWidget {
  final ForecastDay forecastDay;
  const WeatherForecastWeek({super.key, required this.forecastDay});

  @override
  Widget build(BuildContext context) {
    DateTime now = forecastDay.data;

    String weekday = DateFormat('EEEE', 'ru_RU').format(now);

    String capitalizedWeekday = weekday[0].toUpperCase() + weekday.substring(1);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(capitalizedWeekday, style: TextStyle(fontSize: 15)),
          SizedBox(
            width: 105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https:${forecastDay.day.condition.icon}',
                  width: 25,
                  height: 25,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),

                Text(
                  '${forecastDay.day.mintempC.toInt()}°',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF015ABC),
                  ),
                ),

                Text(
                  '${forecastDay.day.maxtempC.toInt()}°',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
