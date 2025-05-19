import 'package:forecast/features/Settings/domain/repository/settings_repository.dart';
import 'package:forecast/features/Settings/domain/usecase/get_theme_data_usecase.dart';

class ChangeThemeUsecase {
  final SettingsRepository settingsRepository;
  final GetThemeDataUsecase getThemeData;

  ChangeThemeUsecase({
    required this.settingsRepository,
    required this.getThemeData,
  });

  Future<void> call() async {
    final bool theme = await getThemeData();
    await settingsRepository.changeTheme(!theme);
  }
}
