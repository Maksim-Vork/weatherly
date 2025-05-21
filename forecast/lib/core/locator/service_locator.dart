import 'package:forecast/core/service/dio_service.dart';
import 'package:forecast/features/City/data/datasource/local_data_source.dart';
import 'package:forecast/features/City/data/repository/city_repository.dart';
import 'package:forecast/features/City/domain/repository/abstract_city_repository.dart';
import 'package:forecast/features/City/domain/usecase/usecases.dart';
import 'package:forecast/features/Settings/data/datasource/settings_datasource.dart';
import 'package:forecast/features/Settings/data/repository/settings_repository_impl.dart';
import 'package:forecast/features/Settings/domain/repository/settings_repository.dart';
import 'package:forecast/features/Settings/domain/usecase/usecases.dart';
import 'package:forecast/features/Weather/data/datasource/current_weather_datasource.dart';
import 'package:forecast/features/Weather/data/repository/weather_repository_impl.dart';
import 'package:forecast/features/Weather/domain/repository/current_weather_repository.dart';
import 'package:forecast/features/Weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // shered preferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  // service
  getIt.registerLazySingleton(() => DioService());

  // data source
  getIt.registerLazySingleton(() => LocalDataSource(prefs: getIt()));
  getIt.registerLazySingleton(() => CurrentWeatherDatasource(getIt()));
  getIt.registerLazySingleton(() => SettingsDataSource(prefs: getIt()));

  // repository
  getIt.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(settingsDataSource: getIt()),
  );

  // usecase
  getIt.registerLazySingleton(() => SaveCityUsecase(getIt()));
  getIt.registerLazySingleton(() => GetCityUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateCityUsecase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentWeatherUsecase(getIt()));
  getIt.registerLazySingleton(() => GetThemeDataUsecase(getIt()));
  getIt.registerLazySingleton(() => ChangeThemeUsecase(getIt(), getIt()));
}
