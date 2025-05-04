import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_bloc.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_state.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is WeatherLoaded) {
          return HomeSrceen(weather: state.weather);
        } else {
          return Text('Ошибка отображения экрана погоды');
        }
      },
    );
  }
}

class HomeSrceen extends StatelessWidget {
  final Weather weather;
  const HomeSrceen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(weather.temperature.toString()));
  }
}
