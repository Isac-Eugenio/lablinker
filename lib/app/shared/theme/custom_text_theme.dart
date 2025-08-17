import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme {
  TextTheme get theme => TextTheme(
    headlineLarge: GoogleFonts.orbitron(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 14,
      color: Colors.white70,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 24,
      color: Colors.white70,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge:  GoogleFonts.inter(
      fontSize: 40,
      color: Colors.white70,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.orbitron(
      fontSize: 78,
      color: Colors.white70,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.orbitron(
      fontSize: 40,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.orbitron(
      fontSize: 20,
      color: Colors.white70,
      fontWeight: FontWeight.w600,
    ),
  );
}
