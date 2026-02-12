import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_language_enum.dart';

final languageProvider =
    NotifierProvider<LanguageController, AppLanguage>(() => LanguageController());

class LanguageController extends Notifier<AppLanguage> {
  final AppLanguage initialLang;

  LanguageController([this.initialLang = AppLanguage.en]);

  @override
  AppLanguage build() => initialLang;

  Future<void> setLanguage(AppLanguage lang) async {
    state = lang; // solo aquí dentro
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang.name);
  }

  // Método estático para cargar idioma guardado
  static Future<AppLanguage> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('language');
    if (saved == null) return AppLanguage.en;
    return AppLanguage.values.firstWhere(
      (e) => e.name == saved,
      orElse: () => AppLanguage.en,
    );
  }
}
