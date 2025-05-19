import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:forecast/features/Weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_bloc.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_event.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_state.dart';
import 'package:forecast/features/Weather/presentation/pages/weather_page/widgets/app_bar.dart';
import 'package:forecast/features/Weather/presentation/pages/weather_page/widgets/current_weather.dart';
import 'package:forecast/features/Weather/presentation/pages/weather_page/widgets/hourly_weather.dart';
import 'package:forecast/features/Weather/presentation/pages/weather_page/widgets/week_weather.dart';

class WeatherScreen extends StatelessWidget {
  final GetCityUsecase getCityUsecase;
  final GetCurrentWeatherUsecase getCurrentWeatherUsecase;

  const WeatherScreen({
    super.key,
    required this.getCityUsecase,
    required this.getCurrentWeatherUsecase,
  });

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    // вызываеться при построении
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (weatherBloc.state is WeatherInitial) {
        weatherBloc.add(GetWeatherEvent());
      }
    });

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is WeatherLoaded) {
          return HomeSrceen(weather: state.weather);
        } else if (state is WeatherError) {
          return Scaffold(body: Center(child: Text(state.error)));
        } else if (state is WeatherInitial) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Состояние WeatherInitial'),
                  ElevatedButton(
                    onPressed: () {
                      weatherBloc.add(GetWeatherEvent());
                    },
                    child: Text('Повторить'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: Text('Ошибка отображения экрана погоды')),
          );
        }
      },
    );
  }
}

class HomeSrceen extends StatefulWidget {
  final Weather weather;
  const HomeSrceen({super.key, required this.weather});

  @override
  State<HomeSrceen> createState() => _HomeSrceenState();
}

class _HomeSrceenState extends State<HomeSrceen> {
  @override
  Widget build(BuildContext context) {
    final weather = widget.weather;

    return Scaffold(
      backgroundColor: Color(0xFF5698DE),
      appBar: AppBar(automaticallyImplyLeading: false, title: AppBarWidget()),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0059B7), Color(0xFFA1CEFF)],
            // colors: [
            //   const Color.fromARGB(255, 255, 206, 46),
            //   const Color.fromARGB(255, 255, 251, 196),
            // ], для темной темы
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 55),
                CurrentWeather(weather: weather),

                SizedBox(height: 65),
                HourlyWeather(weather: weather),
                SizedBox(height: 13),
                Row(
                  children: [
                    Text(
                      'Погода на неделю',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),
                WeekWeather(weather: weather),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
