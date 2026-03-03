import 'package:flutter/material.dart';

class AppColorPair {
  final Color light;
  final Color dark;

  const AppColorPair(this.light, this.dark);
}

class AppColors {
  // Background App
  static const surface = AppColorPair(
    Colors.white,
    Colors.black,
  );

  static const onSurface = AppColorPair(
    Colors.black,
    Colors.white,
  );

  static const surfaceContainer = AppColorPair(
    Colors.grey,
    Color(0xFF2C2C2C),
  );

  static const onSurfaceContainer = AppColorPair(
    Colors.black87,
    Colors.white70,
  );

  static const primary = AppColorPair(
    Color.fromARGB(255, 202, 80, 49),
    Color.fromARGB(255, 56, 21, 13),
  );

  static const onPrimary = AppColorPair(
    Colors.white,
    Colors.white,
  );

  static const primaryContainer = AppColorPair(
    Color(0xFFFFDAD2),
    Color(0xFF31111D),
  );

  static const onPrimaryContainer = AppColorPair(
    Colors.black,
    Colors.white,
  );

  static const secondary = AppColorPair(
    Color(0xFF6750A4),
    Color(0xFFD0BCFF),
  );

  static const onSecondary = AppColorPair(
    Colors.white,
    Color(0xFF1E1E1E),
  );

  static const secondaryContainer = AppColorPair(
    Color(0xFFEADDFF),
    Color(0xFF4A4458),
  );

  static const onSecondaryContainer = AppColorPair(
    Colors.black,
    Colors.white,
  );

  static const error = AppColorPair(
    Color(0xFFB3261E),
    Color(0xFFF2B8B5),
  );

  static const onError = AppColorPair(
    Colors.white,
    Colors.black,
  );
  static const errorContainer = AppColorPair(
    Color(0xFFFFDAD6),
    Color(0xFF8C1D18),
  );

  static const onErrorContainer = AppColorPair(
    Colors.black,
    Colors.white,
  );

  static const outline = AppColorPair(
    Color(0xFF79747E),
    Color(0xFF938F99),
  );

  // shadow: Colors.black,
  // inverseSurface: Colors.white,
  // onInverseSurface: Colors.black,
  // inversePrimary: Color.fromARGB(255, 20, 11, 116),
  // surfaceTint: Color.fromARGB(255, 20, 11, 116),
}
