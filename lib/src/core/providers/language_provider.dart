import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/services/app_settings_service.dart';

final appSettingsServiceProvider = Provider<AppSettingsService>((ref) {
  return AppSettingsService();
});

final languageProvider =
    NotifierProvider<LanguageController, String>(() {
  return LanguageController();
});

class LanguageController extends Notifier<String> {
  late final AppSettingsService _service;

  @override
  String build() {
    _service = ref.read(appSettingsServiceProvider);

    // Valor inicial (por defecto: "en")
    _load();
    return "en";
  }

  Future<void> _load() async {
    final saved = await _service.getLanguage();
    if (saved != null) {
      state = saved;
    }
  }

  Future<void> setLanguage(String code) async {
    state = code;
    await _service.setLanguage(code);
  }
}
