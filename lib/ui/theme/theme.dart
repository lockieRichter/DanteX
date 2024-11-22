import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightThemeData() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.white,
    );
    return ThemeData(
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.nunito().fontFamily,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  static ThemeData darkThemeData() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.dark,
    );

    return ThemeData(
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.nunito().fontFamily,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
