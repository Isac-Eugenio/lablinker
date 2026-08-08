import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class ThemeApp {
  // ============================================================
  // CORES PRINCIPAIS
  // ============================================================

  static Color seedColor = Color(0xFF1976D2);

  static Color primaryColor = Color(0xFF1976D2);

  static Color scaffoldBackground = Colors.blueAccent;

  // ============================================================
  // APP BAR
  // ============================================================

  static Color appBarBackground = Color(0xFF1976D2);

  static Color appBarForeground = Colors.white;

  // ============================================================
  // TEXTOS
  // ============================================================

  static Color textPrimary = Colors.white;

  static Color textSecondary = Colors.white70;

  static Color textHint = Colors.black54;

  static Color get labelText => Colors.lightBlue.shade400;

  // ============================================================
  // CARD
  // ============================================================

  static Color cardBackground = scaffoldBackground.withAlpha(10);

  static Color cardBorder = Colors.white70;

  // ============================================================
  // LIST TILE
  // ============================================================

  static Color get listTileBackground => Colors.lightBlue.shade900;

  static Color get listTileBorder => Colors.blue.shade100;

  static Color listTileIcon = Color(0xFF1976D2);

  static Color listTileText = Colors.black87;

  static Color listTileSubtitle = Colors.black54;

  // ============================================================
  // BUTTON
  // ============================================================

  static Color buttonBackground = Color(0xFF1976D2);

  static Color buttonForeground = Colors.white;

  // ============================================================
  // INPUT
  // ============================================================

  static Color inputBackground = Colors.white;

  static Color get inputBorder => Colors.lightBlue.shade200;

  static Color get inputFocusedBorder => Colors.lightBlue.shade400;

  static Color get inputLabel => Colors.lightBlue.shade400;

  // ============================================================
  // TEXT BUTTON
  // ============================================================

  static Color textButtonForeground = Colors.white;

  // ============================================================
  // STATUS
  // ============================================================

  static Color success = Colors.green;

  static Color error = Colors.red;

  static Color warning = Colors.orange;

  // ============================================================
  // THEME DATA
  // ============================================================

  static ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),

    useMaterial3: true,

    scaffoldBackgroundColor: scaffoldBackground,

    // ----------------------------------------------------------
    // APP BAR
    // ----------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: appBarBackground,
      foregroundColor: appBarForeground,
      elevation: 2,

      titleTextStyle: GoogleFonts.orbitron(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: appBarForeground,
      ),
    ),

    // ----------------------------------------------------------
    // TEXT THEME
    // ----------------------------------------------------------
    textTheme: TextTheme(
      displayLarge: GoogleFonts.orbitron(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      displayMedium: GoogleFonts.orbitron(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      displaySmall: GoogleFonts.orbitron(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      bodyLarge: GoogleFonts.roboto(fontSize: 16, color: textPrimary),

      bodyMedium: GoogleFonts.roboto(fontSize: 14, color: textSecondary),

      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: textHint,
      ),

      labelLarge: GoogleFonts.roboto(fontSize: 14, color: labelText),

      labelMedium: GoogleFonts.orbitron(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      labelSmall: GoogleFonts.orbitron(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      titleMedium: GoogleFonts.orbitron(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      titleLarge: GoogleFonts.orbitron(
        fontSize: 60,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
    ),

    // ----------------------------------------------------------
    // CARD
    // ----------------------------------------------------------
    cardTheme: CardThemeData(
      color: cardBackground,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cardBorder, width: 1.2),
      ),
    ),

    // ----------------------------------------------------------
    // LIST TILE
    // ----------------------------------------------------------
    listTileTheme: ListTileThemeData(
      tileColor: listTileBackground,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: listTileBorder, width: 1.2),
      ),

      iconColor: listTileIcon,

      textColor: listTileText,

      titleTextStyle: GoogleFonts.orbitron(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: listTileText,
      ),

      subtitleTextStyle: GoogleFonts.roboto(
        fontSize: 13,
        color: listTileSubtitle,
      ),

      style: ListTileStyle.list,
    ),

    // ----------------------------------------------------------
    // ELEVATED BUTTON
    // ----------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackground,
        foregroundColor: buttonForeground,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        textStyle: GoogleFonts.orbitron(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),

        elevation: 6,
      ),
    ),

    // ----------------------------------------------------------
    // INPUT
    // ----------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,

      fillColor: inputBackground,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: inputBorder),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: inputFocusedBorder, width: 2),
      ),

      labelStyle: GoogleFonts.roboto(color: inputLabel),
    ),

    // ----------------------------------------------------------
    // TEXT BUTTON
    // ----------------------------------------------------------
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: textButtonForeground,

        textStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
