import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_language_enum.dart';

final languageProvider = NotifierProvider<LanguageController, AppLanguage>(() {
  return LanguageController();
});

class LanguageController extends Notifier<AppLanguage> {
  @override
  AppLanguage build() => AppLanguage.en;

  void setLanguage(AppLanguage lang) {
    state = lang;
  }
}
