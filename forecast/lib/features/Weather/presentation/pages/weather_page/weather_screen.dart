import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:forecast/features/Weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_bloc.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_event.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_state.dart';

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
    return BlocProvider(
      create:
          (context) =>
              WeatherBloc(getCityUsecase, getCurrentWeatherUsecase)
                ..add(GetWeatherEvent()),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return HomeSrceen(weather: state.weather);
          } else {
            return Text('Ошибка отображения экрана погоды');
          }
        },
      ),
    );
  }
}

class HomeSrceen extends StatelessWidget {
  final Weather weather;
  const HomeSrceen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5698DE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              padding: EdgeInsets.all(0),
              onPressed: () {},
              icon: Icon(Icons.settings, size: 34),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          children: [
            SizedBox(height: 55),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    'https:${weather.current.condition.icon}',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain, // было contain
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
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                  const Text(
                    '5°/15°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    weather.nameCity,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 65),
            Container(
              width: double.infinity,
              height: 87,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return WeatherHour();
                  },
                  separatorBuilder:
                      (context, index) =>
                          Container(width: 2, color: Color(0xFFDDDDDD)),
                  itemCount: 7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherHour extends StatelessWidget {
  const WeatherHour({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Center(
        child: Column(
          children: [
            Text('8:00'),
            Image.network(
              'https://cdn.weatherapi.com/weather/64x64/day/116.png',
              width: 30,
              height: 30,
              fit: BoxFit.contain, // было contain
              filterQuality: FilterQuality.high,
            ),
            Text(
              '8°',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
