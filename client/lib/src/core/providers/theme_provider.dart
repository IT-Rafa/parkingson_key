import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/app_settings_service_provider.dart'
    show appSettingsServiceProvider;
import 'package:parkingson_key/src/core/services/app_settings_service.dart';

final themeProvider = NotifierProvider<ThemeController, String>(() {
  return ThemeController();
});

class ThemeController extends Notifier<String> {
  late final AppSettingsService _service;

  @override
  String build() {
    _service = ref.read(appSettingsServiceProvider);

    // valor por defecto
    _load();
    return "system";
  }

  Future<void> _load() async {
    final saved = await _service.getTheme();
    if (saved != null) {
      state = saved;
    }
  }

  Future<void> setTheme(String mode) async {
    state = mode;
    await _service.setTheme(mode);
  }
}
