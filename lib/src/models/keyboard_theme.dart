import 'package:flutter/material.dart';

class KeyboardTheme {
  final Color keyBackground;
  final Color keyText;
  final Color specialKey;
  final Color keyboardBackground;

  const KeyboardTheme({
    required this.keyBackground,
    required this.keyText,
    required this.specialKey,
    required this.keyboardBackground,
  });
}

class KeyboardThemes {
  static const light = KeyboardTheme(
    keyBackground: Colors.white,
    keyText: Colors.black,
    specialKey: Colors.blue,
    keyboardBackground: Color(0xFFEFEFEF),
  );

  static const dark = KeyboardTheme(
    keyBackground: Color(0xFF2C2C2C),
    keyText: Colors.white,
    specialKey: Colors.lightBlue,
    keyboardBackground: Color(0xFF121212),
  );
}
