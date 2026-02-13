import 'package:flutter/material.dart';

class AppColors {
  // primary
  static const Color primaryLight = Color.fromARGB(255, 165, 70, 46);
  static const Color primaryDark = Color.fromARGB(255, 20, 11, 116);
  // onPrimary
  static const Color onPrimaryLight = Colors.green;
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

  // key vowels color
  static const Color keyVowelColorLight = Color.fromARGB(96, 0, 0, 0);
  static const Color keyVowelColorDark = Colors.black38;

  // key affirmative/negative color
  static const Color keyYesNOColorLight = Colors.red;
  static const Color keyYesNOColorDark = Colors.red;

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

        static Color vowels(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? keyVowelColorLight
      : keyVowelColorDark;
}
