/*
------------------------------------
Arquivo: theme_repository.dart
Descrição: Repositório que fornece os temas claro e escuro do app, incluindo cores, fontes e estilos de widgets
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeRepository {
  // Define se o tema atual é escuro
  final bool isDarkMode;

  ThemeRepository({required this.isDarkMode});

  // Retorna o tema baseado no modo
  ThemeData get theme => isDarkMode ? darkTheme : lightTheme;

  // Getter para tema claro
  ThemeData get light => lightTheme;

  // Getter para tema escuro
  ThemeData get dark => darkTheme;
}

/// ======== Tema Claro ========
final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1976D2),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.blueAccent,

  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF1976D2),
    foregroundColor: Colors.white,
    elevation: 2,
    titleTextStyle: GoogleFonts.orbitron(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  textTheme: TextTheme(
    displayLarge: GoogleFonts.orbitron(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: GoogleFonts.orbitron(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: GoogleFonts.orbitron(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
    bodyLarge: GoogleFonts.roboto(fontSize: 16, color: Colors.white),
    bodyMedium: GoogleFonts.roboto(fontSize: 14, color: Colors.white70),
    bodySmall: GoogleFonts.roboto(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold),
    labelLarge: GoogleFonts.roboto(fontSize: 14, color: Colors.lightBlue.shade400),
    labelMedium: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    labelSmall: GoogleFonts.orbitron(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: GoogleFonts.orbitron(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  // Tema para cards
  cardTheme: CardThemeData(
    color: Colors.white70,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.white70, width: 1.2),
    ),
  ),

  // Tema para ListTiles
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.blue.shade100, width: 1.2),
    ),
    iconColor: const Color(0xFF1976D2),
    textColor: Colors.black87,
    titleTextStyle: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
    subtitleTextStyle: GoogleFonts.roboto(fontSize: 13, color: Colors.black54),
    style: ListTileStyle.list,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1976D2),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold),
      elevation: 6,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.lightBlue.shade200)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.lightBlue.shade400, width: 2)),
    labelStyle: GoogleFonts.roboto(color: Colors.lightBlue.shade400),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      textStyle: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
    ),
  ),
);

/// ======== Tema Escuro ========
final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF1976D2),
    secondary: Colors.lightBlue.shade400,
    surface: const Color(0xFF102A43),
    onSurface: Colors.white,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF0D1B2A),

  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF1976D2),
    foregroundColor: Colors.white,
    elevation: 4,
    titleTextStyle: GoogleFonts.orbitron(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
  ),

  textTheme: TextTheme(
    displayLarge: GoogleFonts.orbitron(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: GoogleFonts.orbitron(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: GoogleFonts.orbitron(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
    bodyLarge: GoogleFonts.roboto(fontSize: 16, color: Colors.white),
    bodyMedium: GoogleFonts.roboto(fontSize: 14, color: Colors.white70),
    labelLarge: GoogleFonts.roboto(fontSize: 14, color: Colors.lightBlue.shade400),
    titleMedium: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  cardTheme: CardThemeData(
    color: Colors.white10,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Colors.white24, width: 1.2),
    ),
  ),

  listTileTheme: ListTileThemeData(
    tileColor: Colors.white10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Colors.white24, width: 1.2),
    ),
    iconColor: Colors.lightBlue,
    textColor: Colors.white,
    titleTextStyle: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    subtitleTextStyle: GoogleFonts.roboto(fontSize: 13, color: Colors.white70),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1976D2),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold),
      elevation: 3,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1B2C44),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white24)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.lightBlue.shade400, width: 2)),
    labelStyle: GoogleFonts.roboto(color: Colors.lightBlue.shade400),
  ),
);
