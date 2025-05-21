import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/core/locator/service_locator.dart';
import 'package:forecast/features/City/domain/usecase/usecases.dart';
import 'package:forecast/features/City/presentation/bloc/bloc.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final SaveCityUsecase saveCityUsecase = getIt<SaveCityUsecase>();
  final GetCityUsecase getCityUsecase = getIt<GetCityUsecase>();

  CityBloc() : super(CityInitial()) {
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
