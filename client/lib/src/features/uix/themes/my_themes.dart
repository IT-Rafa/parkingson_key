import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/themes/app_color_schemes.dart';

class MyThemes {
  static const _fontFamily = 'Commissioner';
  static const _fontFallback = ['Commissioner', 'Raleway'];

  static TextTheme _textTheme() => const TextTheme(
        titleLarge: TextStyle(fontSize: 25),
        titleMedium: TextStyle(fontSize: 20),
        bodyLarge: TextStyle(fontSize: 18),
        bodyMedium: TextStyle(fontSize: 16),
        bodySmall: TextStyle(fontSize: 14),
      );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorSchemes.light,
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFallback,
    textTheme: _textTheme(),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorSchemes.dark,
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFallback,
    textTheme: _textTheme(),
  );
}
