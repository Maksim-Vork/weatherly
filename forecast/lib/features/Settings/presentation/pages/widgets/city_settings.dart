import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_bloc.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_event.dart';

class CitySettings extends StatelessWidget {
  CitySettings({super.key});
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),

      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Сменить город',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 51, 123, 238),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _cityController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () {
                if (_cityController.text.trim().isNotEmpty) {
                  BlocProvider.of<WeatherBloc>(
                    context,
                  ).add(UpdatedWeatherEvent(nameCity: _cityController.text));
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,

                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Сохранить',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
