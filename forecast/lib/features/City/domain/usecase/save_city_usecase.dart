import 'package:forecast/features/AppStart/domain/repository/abstract_city_repository.dart';

class SaveCityUsecase {
  final AbstractCityRepository abstractCityRepository;

  SaveCityUsecase(this.abstractCityRepository);

  Future<void> call(String city) async {
    await abstractCityRepository.saveCity(city);
  }
}
