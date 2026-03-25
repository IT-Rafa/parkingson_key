import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layouts/en_abcde_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layouts/en_consonants_vowels_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layouts/en_qwerty_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layouts/en_numbers_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layouts/es_qwerty_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layouts/es_abcde_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layouts/es_consonants_vowels_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layouts/es_numbers_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_type_enum.dart';

KeyboardLayout keyboardLayoutResolve(KeyboardType type, AppLanguage language) {
  return switch ((language, type)) {
    (AppLanguage.es, KeyboardType.qwerty) => esQwertyKeyboardLayout,
    (AppLanguage.es, KeyboardType.abc) => esAbcdeKeyboardLayout,
    (AppLanguage.es, KeyboardType.consonantsVowels) =>
      esConsonantsVowelsKeyboardLayout,
    (AppLanguage.en, KeyboardType.qwerty) => enQwertyKeyboardLayout,
    (AppLanguage.en, KeyboardType.abc) => enAbcdeKeyboardLayout,
    (AppLanguage.en, KeyboardType.consonantsVowels) =>
      enConsonantsVowelsKeyboardLayout,
    (AppLanguage.es, KeyboardType.numbers) => esNumbersKeyboardLayout,
    (AppLanguage.en, KeyboardType.numbers) => enNumbersKeyboardLayout,
  };
}
