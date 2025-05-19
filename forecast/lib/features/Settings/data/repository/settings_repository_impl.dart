import 'package:forecast/features/Settings/data/datasource/settings_datasource.dart';
import 'package:forecast/features/Settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsDataSource settingsDataSource;

  SettingsRepositoryImpl({required this.settingsDataSource});
  @override
  Future<void> changeTheme(bool theme) async {
    settingsDataSource.changeTheme(theme);
  }

  @override
  Future<bool> getThemeData() async {
    return settingsDataSource.getThemeDataSource();
  }
}
