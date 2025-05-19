import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/core/dio_service.dart';
import 'package:forecast/core/theme/theme.dart';
import 'package:forecast/features/City/data/datasource/local_data_source.dart';
import 'package:forecast/features/City/data/repository/city_repository.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/City/domain/usecase/save_city_usecase.dart';
import 'package:forecast/features/City/domain/usecase/update_city_usecase.dart';
import 'package:forecast/features/City/presentation/bloc/city_bloc.dart';
import 'package:forecast/features/City/presentation/bloc/city_event.dart';
import 'package:forecast/features/City/presentation/pages/login_page/login_screen.dart';
import 'package:forecast/features/Settings/data/datasource/settings_datasource.dart';
import 'package:forecast/features/Settings/data/repository/settings_repository_impl.dart';
import 'package:forecast/features/Settings/domain/usecase/change_theme_usecase.dart';
import 'package:forecast/features/Settings/domain/usecase/get_theme_data_usecase.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_bloc.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_event.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_state.dart';
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

  final settingsDataSource = SettingsDataSource(prefs: prefs);
  final settingsRepository = SettingsRepositoryImpl(
    settingsDataSource: settingsDataSource,
  );
  final getThemeDataUsecase = GetThemeDataUsecase(
    settingsRepository: settingsRepository,
  );
  final changeTnemeUsecase = ChangeThemeUsecase(
    settingsRepository: settingsRepository,
    getThemeData: getThemeDataUsecase,
  );

  runApp(
    DevicePreview(
      enabled: true,
      builder:
          (context) => MyApp(
            saveCityUseCase: saveCityUseCase,
            getCityUseCase: getCityUseCase,
            getCurrentWeatherUsecase: getCurrentWeatherUsecase,
            updateCityUsecase: updateCityUsecase,
            changeThemeUsecase: changeTnemeUsecase,
            getThemeDataUsecase: getThemeDataUsecase,
          ),
    ),
  );
  //   MyApp(
  //    saveCityUseCase: saveCityUseCase,
  // getCityUseCase: getCityUseCase,
  // getCurrentWeatherUsecase: getCurrentWeatherUsecase,
  // updateCityUsecase: updateCityUsecase,
  // changeThemeUsecase: changeTnemeUsecase,
  // getThemeDataUsecase: getThemeDataUsecase,
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  final ChangeThemeUsecase changeThemeUsecase;
  final GetThemeDataUsecase getThemeDataUsecase;
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
    required this.getThemeDataUsecase,
    required this.changeThemeUsecase,
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
              (context) =>
                  SettingsBloc(changeThemeUsecase, getThemeDataUsecase)
                    ..add(GetThemeEvent()),
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
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData ? darkTheme : lightTheme,
            home: LoginScreen(
              getCityUsecase: getCityUseCase,
              getCurrentWeatherUsecase: getCurrentWeatherUsecase,
            ),
          );
        },
      ),
    );
  }
}
