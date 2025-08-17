import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/theme/theme_widgets.dart';

class CustomElevateButtonTheme {
  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: ColorsPrimarySystem.primaryColor.color,
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  );

  ElevatedButtonThemeData get theme =>
      ElevatedButtonThemeData(style: _buttonStyle);
}
