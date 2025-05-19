import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    secondary: const Color.fromARGB(255, 0, 75, 174),
    primary: Color.fromARGB(157, 108, 108, 108),
  ),
);
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 32, 32, 32),
    secondary: const Color.fromARGB(255, 208, 197, 0),
    primary: Color.fromARGB(196, 84, 84, 84),
  ),
);
