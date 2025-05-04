import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/City/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/City/domain/usecase/save_city_usecase.dart';
import 'package:forecast/features/City/presentation/bloc/city_event.dart';
import 'package:forecast/features/City/presentation/bloc/city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final SaveCityUsecase saveCityUsecase;
  final GetCityUsecase getCityUsecase;

  CityBloc(this.saveCityUsecase, this.getCityUsecase) : super(CityInitial()) {
    on<AddCityEvent>(_onAddCity);
    on<CheckCityEvent>(_onCheck);
  }

  void _onAddCity(AddCityEvent event, Emitter<CityState> emit) async {
    try {
      emit(CityLoading());
      await saveCityUsecase(event.nameCity);
      emit(CityFound());
    } catch (e) {
      emit(CityError('Ошибка при добавлении: ${e.toString()}'));
    }
  }

  void _onCheck(CheckCityEvent event, Emitter<CityState> emit) async {
    try {
      emit(CityLoading());
      final String city = await getCityUsecase();
      if (city == 'Unknown City') {
        emit(CityNotFound());
      } else {
        emit(CityFound());
      }
    } catch (e) {
      emit(CityError('Ошибка при проверке: ${e.toString()}'));
    }
  }
}
