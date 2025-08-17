import 'custom_app_bar_theme.dart';
import 'custom_color_scheme_theme.dart';
import 'custom_elevated_button_theme.dart';
import 'custom_floating_action_button_theme.dart';
import 'package:flutter/material.dart';

import 'custom_icon_theme.dart';
import 'custom_text_theme.dart';

enum ColorsPrimarySystem {
  backgroundPrimaryColor(Colors.blueAccent),
  primaryColor(Color(0xFF0C0D47));

  final dynamic color;

  const ColorsPrimarySystem(this.color);
}

const List<Color> palette = [
  Color(0xFFFF6F00), // Laranja vibrante (complementar quente)
  Color(0xFFFF8F00), // Laranja médio
  Color(0xFFFFB300), // Amarelo queimado
  Color(0xFFFFC107), // Amarelo vivo
  Color(0xFFFFA000), // Laranja mais escuro
  Color(0xFFFB8C00), // Laranja queimado mais suave
  Color(0xFFEF6C00), // Laranja escuro queimado
];

final CustomAppBarTheme _customAppBarTheme = CustomAppBarTheme();
final CustomColorSchemeTheme _customColorSchemeTheme = CustomColorSchemeTheme();
final CustomTextTheme _customTextTheme = CustomTextTheme();
final CustomIconTheme _customIconTheme = CustomIconTheme();
final CustomFloatingActionButtonTheme _customFloatingActionButtonTheme =
    CustomFloatingActionButtonTheme();
final CustomElevateButtonTheme _customElevateButtonTheme =
    CustomElevateButtonTheme();

enum ThemeWidgets {
  system;

  ThemeData get themeData => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsPrimarySystem.primaryColor.color,
    useMaterial3: false,
    colorScheme: _customColorSchemeTheme.theme,
    textTheme: _customTextTheme.theme,
    appBarTheme: _customAppBarTheme.theme,
    iconTheme: _customIconTheme.theme,
    floatingActionButtonTheme: _customFloatingActionButtonTheme.theme,
    elevatedButtonTheme: _customElevateButtonTheme.theme,
  );
}
