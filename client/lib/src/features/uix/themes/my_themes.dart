import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/themes/app_colors.dart';

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
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.primaryLight,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primaryLight,
          onPrimary: AppColors.onPrimaryLight,
          error: AppColors.errorLight,
          onError: AppColors.errorLight,
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundAppBarLight,
      foregroundColor: AppColors.foregroundAppBarLight,
    ),

    // COMMON VALUES IN LIGHT THEME
    textTheme: _textTheme(),
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    materialTapTargetSize: _tapTargetSize,
    visualDensity: _visualDensity,
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.primaryDark,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.primaryDark,
          onPrimary: AppColors.onPrimaryDark,
          error: AppColors.errorDark,
          onError: AppColors.errorDark,
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundAppBarDark,
      foregroundColor: AppColors.foregroundAppBarDark,
    ),

    // COMMON VALUES IN DARK THEME
    textTheme: _textTheme(),

    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    materialTapTargetSize: _tapTargetSize,
    visualDensity: _visualDensity,
  );
}
