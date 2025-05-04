abstract class AbstractCityRepository {
  Future<void> saveCity(String city);
  Future<String> getCity();
}
