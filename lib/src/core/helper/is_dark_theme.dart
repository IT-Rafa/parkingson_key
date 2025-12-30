import 'package:flutter/material.dart';

bool isDarkTheme(String theme, Brightness systemBrightness) {
  switch (theme) {
    case 'dark':
      return true;
    case 'light':
      return false;
    case 'system':
    default:
      return systemBrightness == Brightness.dark;
  }
}
