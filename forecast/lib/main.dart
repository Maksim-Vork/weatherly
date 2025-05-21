import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/core/locator/service_locator.dart';
import 'package:forecast/core/theme/theme.dart';
import 'package:forecast/features/City/presentation/bloc/city_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/city_event.dart';
import 'package:forecast/features/City/presentation/pages/login_page/login_screen.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_bloc.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_event.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_state.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(DevicePreview(enabled: true, builder: (context) => MyApp()));
  //   MyApp(
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CityBloc()..add(CheckCityEvent())),
        BlocProvider(create: (context) => SettingsBloc()..add(GetThemeEvent())),
        BlocProvider(create: (context) => WeatherBloc()),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData ? darkTheme : lightTheme,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
