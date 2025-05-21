import 'package:forecast/features/City/domain/repository/abstract_city_repository.dart';

class SaveCityUsecase {
  final CityRepository abstractCityRepository;

  SaveCityUsecase(this.abstractCityRepository);

  Future<void> call(String city) async {
    await abstractCityRepository.saveCity(city);
  }
}
