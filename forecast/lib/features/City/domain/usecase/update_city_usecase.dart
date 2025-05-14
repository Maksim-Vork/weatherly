import 'package:forecast/features/City/domain/repository/abstract_city_repository.dart';

class UpdateCityUsecase {
  final AbstractCityRepository abstractCityRepository;

  UpdateCityUsecase(this.abstractCityRepository);

  Future<void> call(String city) async {
    await abstractCityRepository.saveCity(city);
  }
}
