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
              child: SizedBox(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/login_img.png',
                      width: 139,
                      height: 151,
                    ),
                    SizedBox(
                      width: 150,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            weather.temperature.toInt().toString(),

                            style: TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 5,
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
                    ),
                    SizedBox(height: 15),
                    Text(
                      '5°/15°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Гомель',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
