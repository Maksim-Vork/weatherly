import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/Settings/presentation/pages/setting_screen.dart';
import 'package:forecast/features/Weather/domain/entity/forecast_day.dart';
import 'package:forecast/features/Weather/domain/entity/hour.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:forecast/features/Weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_bloc.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_event.dart';

import 'package:forecast/features/Weather/presentation/bloc/weather_state.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

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
    // Получаем WeatherBloc из контекста
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    // Вызываем событие при первом построении виджета
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final hours = widget.weather.forecast.forecastDay[0].hour;
    final index = hours.indexWhere((hour) => hour.time.hour == now.hour);
    print(widget.weather.forecast.forecastDay.length);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && index != -1) {
        _scrollController.jumpTo(index * 70.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final weather = widget.weather;
    final List<ForecastDay> listForecast = weather.forecast.forecastDay;

    return Scaffold(
      backgroundColor: Color(0xFF5698DE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Chill',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 5),
                Text(
                  'прогноз',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0D62BD),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
              icon: Icon(Icons.settings, size: 34),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0059B7), Color(0xFFA1CEFF)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 55),
                Center(
                  child: Column(
                    children: [
                      Image.network(
                        'https:${weather.current.condition.icon}',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            weather.current.temperature.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              '°',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${weather.forecast.forecastDay[0].day.mintempC.toInt()}°',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '/',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${weather.forecast.forecastDay[0].day.maxtempC.toInt()}°',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        weather.nameCity,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(
                      context,
                    ).add(GetWeatherEvent());
                  },
                  child: Text('Обновить'),
                ),
                SizedBox(height: 65),
                Container(
                  width: double.infinity,
                  height: 92,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 8,
                    ),
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return WeatherHour(
                          hour: weather.forecast.forecastDay[0].hour[index],
                        );
                      },
                      separatorBuilder:
                          (context, index) =>
                              Container(width: 2, color: Color(0xFFDDDDDD)),
                      itemCount: weather.forecast.forecastDay[0].hour.length,
                    ),
                  ),
                ),
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Важно!
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        child: Column(
                          children: List.generate(
                            weather.forecast.forecastDay.length,
                            (index) => WeatherForecastWeek(
                              forecastDay: listForecast[index],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
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
