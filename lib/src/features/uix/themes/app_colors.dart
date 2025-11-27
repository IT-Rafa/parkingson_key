import 'package:flutter/material.dart';

class AppColors {
  // primary
  static const Color primaryLight = Color.fromARGB(255, 46, 163, 165);
  static const Color primaryDark = Color.fromARGB(255, 20, 11, 116);
  // onPrimary
  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Colors.white;
  // error
  static const Color errorLight = Colors.red;
  static const Color errorDark = Colors.red;
  // onError
  static const Color onErrorLight = Colors.red;
  static const Color onErrorDark = Colors.red;
  // backgroundAppBar
  static const Color backgroundAppBarLight = primaryLight;
  static const Color backgroundAppBarDark = Colors.black;
  // foregroundAppBar
  static const Color foregroundAppBarLight = Colors.white;
  static const Color foregroundAppBarDark = Colors.white;

  // Getters upon brightness
  static Color primary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? primaryLight
      : primaryDark;

  static Color onPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? onPrimaryLight
      : onPrimaryDark;

  static Color key(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? Colors.white
      : Colors.black54;
      
  static Color onKey(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? Colors.black
      : Colors.white;

  static Color error(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? errorLight : errorDark;

  static Color onError(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? onErrorLight
      : onErrorDark;

  static Color backgroundAppBar(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? backgroundAppBarLight
      : backgroundAppBarDark;

  static Color foregroundAppBar(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? foregroundAppBarLight
      : foregroundAppBarDark;
}
