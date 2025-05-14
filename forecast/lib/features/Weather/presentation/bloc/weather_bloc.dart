import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/City/domain/usecase/update_city_usecase.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:forecast/features/Weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_event.dart';

import 'package:forecast/features/Weather/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final UpdateCityUsecase updateCityUsecase;
  final GetCityUsecase getCityUsecase;
  final GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  WeatherBloc(
    this.getCityUsecase,
    this.getCurrentWeatherUsecase,
    this.updateCityUsecase,
  ) : super(WeatherInitial()) {
    on<GetWeatherEvent>(_onGet);
    on<UpdatedWeatherEvent>(_onUpdated);
  }

  void _onGet(GetWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      final String city = await getCityUsecase();
      final Weather weather = await getCurrentWeatherUsecase(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e as String));
    }
  }

  void _onUpdated(UpdatedWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      await updateCityUsecase(event.nameCity);
      final String city = await getCityUsecase();
      final Weather weather = await getCurrentWeatherUsecase(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e as String));
    }
  }
}
