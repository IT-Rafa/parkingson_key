import 'package:flutter/material.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';

Locale localeFromLanguageCode(AppLanguage lang) {
  switch (lang) {
    case AppLanguage.es:
      return const Locale('es');
    case AppLanguage.en:
      return const Locale('en');
  }
}
