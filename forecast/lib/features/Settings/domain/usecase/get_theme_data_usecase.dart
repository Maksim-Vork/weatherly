import 'package:forecast/features/Settings/domain/repository/settings_repository.dart';

class GetThemeDataUsecase {
  final SettingsRepository settingsRepository;

  GetThemeDataUsecase({required this.settingsRepository});

  Future<bool> call() async {
    final bool theme = await settingsRepository.getThemeData();
    return theme;
  }
}
