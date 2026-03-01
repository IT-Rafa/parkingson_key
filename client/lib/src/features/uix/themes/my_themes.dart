import 'package:flutter/material.dart';

// Class to contain the app's themes .
class MyThemes {
  // COMMON VALUES TO LIGHT AND DARK THEMES
  // font family
  static const String _fontFamily = 'Commissioner';
  static const List<String> _fontFamilyFallback = ['Commissioner', 'Raleway'];

  // text styles
  static TextTheme _textTheme() => TextTheme(
        titleLarge: TextStyle(fontSize: 25),
        titleMedium: TextStyle(fontSize: 20),
        bodyLarge: TextStyle(fontSize: 18),
        bodyMedium: TextStyle(fontSize: 16),
        bodySmall: TextStyle(fontSize: 14),
      );

  // visual density and tap target size
  static const MaterialTapTargetSize _tapTargetSize =
      MaterialTapTargetSize.padded;
  static const VisualDensity _visualDensity = VisualDensity.standard;

  // VALUES TO LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    // COMMON VALUES IN LIGHT THEME
    textTheme: _textTheme(),
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    materialTapTargetSize: _tapTargetSize,
    visualDensity: _visualDensity,
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(
    // COMMON VALUES IN DARK THEME
    textTheme: _textTheme(),

    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    materialTapTargetSize: _tapTargetSize,
    visualDensity: _visualDensity,
  );
}
