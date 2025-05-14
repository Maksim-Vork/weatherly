import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/core/dio_service.dart';
import 'package:forecast/features/City/data/datasource/local_data_source.dart';
import 'package:forecast/features/City/data/repository/city_repository.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/City/domain/usecase/save_city_usecase.dart';
import 'package:forecast/features/City/domain/usecase/update_city_usecase.dart';
import 'package:forecast/features/City/presentation/bloc/city_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/city_event.dart';
import 'package:forecast/features/City/presentation/pages/login_page/login_screen.dart';
import 'package:forecast/features/Weather/data/datasource/current_weather_datasource.dart';
import 'package:forecast/features/Weather/data/repository/weather_repository_impl.dart';
import 'package:forecast/features/Weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();

  final localDataSource = LocalDataSource(prefs: prefs);
  final cityRepository = CityRepository(localDataSource);
  final saveCityUseCase = SaveCityUsecase(cityRepository);
  final getCityUseCase = GetCityUsecase(cityRepository);
  final updateCityUsecase = UpdateCityUsecase(cityRepository);

  final dioService = DioService();
  final weatherDatasource = CurrentWeatherDatasource(dioService);
  final weatherRepository = WeatherRepositoryImpl(weatherDatasource);
  final getCurrentWeatherUsecase = GetCurrentWeatherUsecase(weatherRepository);

  runApp(
    DevicePreview(
      enabled: true,
      builder:
          (context) => MyApp(
            saveCityUseCase: saveCityUseCase,
            getCityUseCase: getCityUseCase,
            getCurrentWeatherUsecase: getCurrentWeatherUsecase,
            updateCityUsecase: updateCityUsecase,
          ),
    ),
  );
  //   MyApp(
  //     saveCityUseCase: saveCityUseCase,
  //     getCityUseCase: getCityUseCase,
  //     getCurrentWeatherUsecase: getCurrentWeatherUsecase,
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  final UpdateCityUsecase updateCityUsecase;
  final SaveCityUsecase saveCityUseCase;
  final GetCityUsecase getCityUseCase;
  final GetCurrentWeatherUsecase getCurrentWeatherUsecase;

  const MyApp({
    super.key,
    required this.saveCityUseCase,
    required this.getCityUseCase,
    required this.getCurrentWeatherUsecase,
    required this.updateCityUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  CityBloc(saveCityUseCase, getCityUseCase)
                    ..add(CheckCityEvent()),
        ),

        BlocProvider(
          create:
              (context) => WeatherBloc(
                getCityUseCase,
                getCurrentWeatherUsecase,
                updateCityUsecase,
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(
          getCityUsecase: getCityUseCase,
          getCurrentWeatherUsecase: getCurrentWeatherUsecase,
        ),
      ),
    );
  }
}
