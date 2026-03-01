import 'package:flutter/material.dart';

class AppColors {
  static Color primary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Color.fromARGB(255, 165, 70, 46)
          : Color.fromARGB(255, 20, 11, 116);

  static Color onPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.green
          : Colors.white;

  static Color containerBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.grey[300]!
          : Colors.grey[600]!;

  static Color key(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black54;

  static Color onKey(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white;

  static Color error(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.red
          : Colors.red;

  static Color onError(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.red
          : Colors.red;

  static Color backgroundAppBar(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.red
          : Colors.red;

  static Color foregroundAppBar(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.red
          : Colors.red;

  static Color vowels(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Colors.red
          : Colors.red;
}
