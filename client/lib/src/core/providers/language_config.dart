import 'app_language_enum.dart';

String ttsLocaleFromLanguage(AppLanguage lang) {
  switch (lang) {
    case AppLanguage.es:
      return 'es-ES';
    case AppLanguage.en:
      return 'en-US';
  }
}
