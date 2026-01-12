import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard_Layouts/es_abcde_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard_Layouts/es_consonants_vowels_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard_Layouts/es_qwerty_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard_type.dart';

KeyboardLayout resolveKeyboardLayout(KeyboardType type) {
  return switch (type) {
    KeyboardType.qwerty => esQwertyKeyboardLayout,
    KeyboardType.abc => esAbcdeKeyboardLayout,
    KeyboardType.consonantsVowels => esConsonantsVowelsKeyboardLayout,
  };
}
