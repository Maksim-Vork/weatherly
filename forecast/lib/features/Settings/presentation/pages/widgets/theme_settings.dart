import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_bloc.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_event.dart';
import 'package:forecast/features/Settings/presentation/bloc/settings_state.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Сменить тему',

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Темная тема:',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Switch(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      activeColor: Colors.white,
                      activeTrackColor: Theme.of(context).colorScheme.primary,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Color.fromARGB(255, 51, 123, 238),
                      value: state.themeData,
                      onChanged: (bool value) {
                        BlocProvider.of<SettingsBloc>(
                          context,
                        ).add(ChangeThemeEvent());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
