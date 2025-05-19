// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDataSource {
  final SharedPreferences prefs;

  SettingsDataSource({required this.prefs});

  Future<void> changeTheme(bool theme) async {
    try {
      await prefs.setBool('themeData', theme);
    } catch (e) {
      throw Exception("Ошибка при изменении темы: $e");
    }
  }

  Future<bool> getThemeDataSource() async {
    try {
      return prefs.getBool('themeData') ?? false;
    } catch (e) {
      throw Exception("Ошибка при получении темы: $e");
    }
  }
}
