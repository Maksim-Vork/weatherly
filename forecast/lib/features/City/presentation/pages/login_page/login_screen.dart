import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/bloc.dart';
import 'package:forecast/features/City/presentation/pages/login_page/widgets/widgets.dart';
import 'package:forecast/features/Weather/presentation/pages/weather_page/weather_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          if (state is CityLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CityFound) {
            return WeatherScreen();
          } else if (state is CityNotFound) {
            return WelcomScreen();
          } else {
            return ErrorMessege();
          }
        },
      ),
    );
  }
}

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

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
              InputLoginScreen(),
              Column(children: [Text('0.0.1 version'), SizedBox(height: 10)]),
            ],
          ),
        ),
      ),
    );
  }
}
