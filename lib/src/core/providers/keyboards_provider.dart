import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/keyboards/keyboard_spanish_consonants_vowels.dart';
import 'package:parkingson_key/src/models/keyboard_layout_model.dart';

final keyboardsProvider = Provider<List<KeyboardLayoutModel>>((ref) {
  return [
    keyboardSpanishConsonantsVowels,
    keyboardEnglishConsonantsVowels,
  ];
});