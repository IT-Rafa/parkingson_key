import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/app_settings_service_provider.dart';
import 'package:parkingson_key/src/core/services/app_settings_service.dart';

final themeProvider = NotifierProvider<ThemeController, ThemeMode>(() {
  return ThemeController();
});

class ThemeController extends Notifier<ThemeMode> {
  late final AppSettingsService _service;

  @override
  ThemeMode build() {
    _service = ref.read(appSettingsServiceProvider);
    _load(); // carga asíncrona
    return ThemeMode.system; // valor por defecto
  }

  Future<void> _load() async {
    final saved =
        await _service.getTheme(); // suponemos "light"/"dark"/"system"
    if (saved != null) {
      state = _fromString(saved);
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await _service.setTheme(_toString(mode));
  }

  // Helpers para conversión con SharedPreferences
  String _toString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return "light";
      case ThemeMode.dark:
        return "dark";
      default:
        return "system";
    }
  }

  ThemeMode _fromString(String value) {
    switch (value) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
