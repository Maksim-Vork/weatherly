abstract class CityRepository {
  Future<void> saveCity(String city);
  Future<String> getCity();
}
