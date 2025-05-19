import 'package:flutter/material.dart';
import 'package:forecast/features/Weather/domain/entity/hour.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:intl/intl.dart';

class HourlyWeather extends StatefulWidget {
  final Weather weather;
  const HourlyWeather({super.key, required this.weather});

  @override
  State<HourlyWeather> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final hours = widget.weather.forecast.forecastDay[0].hour;
    final index = hours.indexWhere((hour) => hour.time.hour == now.hour);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && index != -1) {
        _scrollController.jumpTo(index * 70.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 92,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return WeatherHour(
              hour: widget.weather.forecast.forecastDay[0].hour[index],
            );
          },
          separatorBuilder:
              (context, index) => Container(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
          itemCount: widget.weather.forecast.forecastDay[0].hour.length,
        ),
      ),
    );
  }
}

class WeatherHour extends StatelessWidget {
  final Hour hour;
  const WeatherHour({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat.Hm().format(hour.time);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Center(
        child: Column(
          children: [
            Text(formattedTime),
            Image.network(
              'https:${hour.condition.icon}',
              width: 34,
              height: 34,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            Text(
              '${hour.tempC.toInt()}°',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
