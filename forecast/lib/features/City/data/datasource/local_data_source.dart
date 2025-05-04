// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences prefs;

  // Конструктор, чтобы использовать инстанс SharedPreferences при создании
  LocalDataSource({required this.prefs});

  // Сохранение города
  Future<void> saveCity(String city) async {
    try {
      await prefs.setString('city', city); // Ожидаем завершение операции
    } catch (e) {
      throw Exception("Ошибка при сохранении города: $e"); // Обработка ошибок
    }
  }

  // Получение города
  Future<String?> getCity() async {
    try {
      return prefs.getString(
        'city',
      ); // Лучше вернуть null, если город не найден
    } catch (e) {
      throw Exception("Ошибка при получении города: $e");
    }
  }
}
