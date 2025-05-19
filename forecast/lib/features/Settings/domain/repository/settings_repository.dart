abstract class SettingsRepository {
  Future<void> changeTheme(bool theme);
  Future<bool> getThemeData();
}
