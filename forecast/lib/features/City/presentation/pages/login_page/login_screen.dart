import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/City/presentation/bloc/city_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/city_state.dart';
import 'package:forecast/features/City/presentation/pages/login_page/widgets/error_messege.dart';
import 'package:forecast/features/City/presentation/pages/login_page/widgets/image_login_screen.dart';
import 'package:forecast/features/City/presentation/pages/login_page/widgets/input_login_screen.dart';
import 'package:forecast/features/Weather/domain/usecase/get_current_weather_usecase.dart';

import 'package:forecast/features/Weather/presentation/pages/weather_page/weather_screen.dart';

class LoginScreen extends StatelessWidget {
  final GetCityUsecase getCityUsecase;
  final GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  const LoginScreen({
    super.key,
    required this.getCityUsecase,
    required this.getCurrentWeatherUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          if (state is CityLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CityFound) {
            return WeatherScreen(
              getCityUsecase: getCityUsecase,
              getCurrentWeatherUsecase: getCurrentWeatherUsecase,
            );
          } else if (state is CityNotFound) {
            return WelcomScreen(
              getCityUsecase: getCityUsecase,
              getCurrentWeatherUsecase: getCurrentWeatherUsecase,
            );
          } else {
            return ErrorMessege();
          }
        },
      ),
    );
  }
}

class WelcomScreen extends StatelessWidget {
  final GetCityUsecase getCityUsecase;
  final GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  const WelcomScreen({
    super.key,
    required this.getCityUsecase,
    required this.getCurrentWeatherUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0059B7), Color(0xFFA1CEFF)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10),
              ImageLoginScreen(),
              InputLoginScreen(
                getCityUsecase: getCityUsecase,
                getCurrentWeatherUsecase: getCurrentWeatherUsecase,
              ),
              Column(children: [Text('0.0.1 version'), SizedBox(height: 10)]),
            ],
          ),
        ),
      ),
    );
  }
}
