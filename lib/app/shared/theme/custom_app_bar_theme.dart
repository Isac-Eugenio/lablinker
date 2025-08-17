import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/theme/theme_widgets.dart';

class CustomAppBarTheme {
  final TextStyle _titleTextStyle = const TextStyle(
    fontFamily: 'ASConcretica',
    fontSize: 40,
    color: Colors.white70,
    fontWeight: FontWeight.w600,
  );

  AppBarTheme get theme => AppBarTheme(
    elevation: 4,
    backgroundColor: ColorsPrimarySystem.primaryColor.color,
    foregroundColor: Colors.white,
    centerTitle: true,
    toolbarHeight: 56,
    actionsPadding: const EdgeInsets.all(4),
    shadowColor: Colors.blueAccent,
    titleTextStyle: _titleTextStyle,
  );
}
