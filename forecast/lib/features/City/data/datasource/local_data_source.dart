// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences prefs;

  LocalDataSource({required this.prefs});

  Future<void> saveCity(String city) async {
    try {
      await prefs.setString('city', city);
    } catch (e) {
      throw Exception("Ошибка при сохранении города: $e");
    }
  }

  // Получение города
  Future<String?> getCity() async {
    try {
      return prefs.getString('city');
    } catch (e) {
      throw Exception("Ошибка при получении города: $e");
    }
  }
}
