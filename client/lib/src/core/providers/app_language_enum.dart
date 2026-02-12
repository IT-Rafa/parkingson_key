import 'package:flutter/material.dart';

enum AppLanguage { es, en }

extension AppLanguageX on AppLanguage {
  Locale get locale {
    switch (this) {
      case AppLanguage.es:
        return const Locale('es');
      case AppLanguage.en:
        return const Locale('en');
    }
  }

  String get code {
    switch (this) {
      case AppLanguage.es:
        return 'es';
      case AppLanguage.en:
        return 'en';
    }
  }
}