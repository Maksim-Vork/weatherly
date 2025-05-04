import 'package:forecast/features/City/domain/repository/abstract_city_repository.dart';

class GetCityUsecase {
  final AbstractCityRepository abstractCityRepository;

  GetCityUsecase(this.abstractCityRepository);

  Future<String> call() async {
    final String city = await abstractCityRepository.getCity();
    return city;
  }
}
