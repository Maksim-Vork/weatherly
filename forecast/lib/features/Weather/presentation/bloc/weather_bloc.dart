import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/Weather/domain/entity/weather.dart';
import 'package:forecast/features/Weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_event.dart';
import 'package:forecast/features/Weather/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<GetWeatherEvent, WeatherState> {
  final GetCityUsecase getCityUsecase;
  final GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  WeatherBloc(this.getCityUsecase, this.getCurrentWeatherUsecase)
    : super(WeatherInitial()) {
    on<GetWeatherEvent>((event, emit) async {
      try {
        emit(WeatherLoading());
        final String city = await getCityUsecase();
        final Weather weather = await getCurrentWeatherUsecase(city);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError(e as String));
      }
    });
  }
}
