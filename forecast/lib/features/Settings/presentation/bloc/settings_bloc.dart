import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/Settings/domain/usecase/change_theme_usecase.dart';
import 'package:forecast/features/Settings/domain/usecase/get_theme_data_usecase.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_event.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ChangeThemeUsecase changeTheme;
  final GetThemeDataUsecase getThemeData;
  SettingsBloc(this.changeTheme, this.getThemeData)
    : super(SettingsState(themeData: false)) {
    on<GetThemeEvent>(_onGetTheme);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  void _onChangeTheme(
    ChangeThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await changeTheme();
    final bool themeData = await getThemeData();

    emit(SettingsState(themeData: themeData));
  }

  void _onGetTheme(GetThemeEvent event, Emitter<SettingsState> emit) async {
    final bool themeData = await getThemeData();
    emit(SettingsState(themeData: themeData));
  }
}
