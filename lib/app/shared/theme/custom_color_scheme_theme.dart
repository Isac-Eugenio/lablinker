import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/theme/theme_widgets.dart';

class CustomColorSchemeTheme {
  ColorScheme get theme => ColorScheme(
    brightness: Brightness.dark,
    primary: ColorsPrimarySystem.primaryColor.color,
    onPrimary: Colors.white,
    secondary: Color(0xFF1E2A78),
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color(0xFF12143A),
    onSurface: Colors.white,
  );
}