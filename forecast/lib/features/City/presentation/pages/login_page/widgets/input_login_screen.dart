import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/city_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/city_event.dart';
import 'package:forecast/features/Weather/presentation/pages/weather_page/weather_screen.dart';

class InputLoginScreen extends StatelessWidget {
  InputLoginScreen({super.key});

  final TextEditingController _controllerCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Введите город',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 5),
        Form(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(30),
            ),
            width: 280,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: TextFormField(
                controller: _controllerCity,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(height: 80),
        SizedBox(
          width: 280,
          height: 70,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Color(0xFF333333),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            onPressed: () {
              BlocProvider.of<CityBloc>(
                context,
              ).add(AddCityEvent(_controllerCity.text));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherScreen()),
              );
            },
            child: Text(
              'Войти',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
