import 'package:parkingson_key/src/models/keyboard/keyboard_Layouts/es_abcde_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_Layouts/es_consonants_vowels_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_Layouts/es_qwerty_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_type_enum.dart';

final keyboardLayoutByType = {
  KeyboardType.qwerty: esQwertyKeyboardLayout,
  KeyboardType.abc: esAbcdeKeyboardLayout,
  KeyboardType.consonantsVowels: esConsonantsVowelsKeyboardLayout,
};
