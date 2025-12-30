import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/theme_provider.dart';
import 'package:parkingson_key/src/models/keyboard_theme.dart';

final keyboardThemeProvider = Provider<KeyboardTheme>((ref) {
  final theme = ref.watch(themeProvider);

  return theme == 'dark'
      ? KeyboardThemes.dark
      : KeyboardThemes.light;
});
