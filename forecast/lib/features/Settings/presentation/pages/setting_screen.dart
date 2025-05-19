import 'package:flutter/material.dart';
import 'package:forecast/features/Settings/presentation/pages/widgets/city_settings.dart';
import 'package:forecast/features/Settings/presentation/pages/widgets/app_bar_settings.dart';
import 'package:forecast/features/Settings/presentation/pages/widgets/theme_settings.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: SettingsAppBar()),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0059B7), Color(0xFFA1CEFF)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            children: [
              SizedBox(height: 27),
              CitySettings(),
              SizedBox(height: 25),
              ThemeSettings(),
            ],
          ),
        ),
      ),
    );
  }
}
