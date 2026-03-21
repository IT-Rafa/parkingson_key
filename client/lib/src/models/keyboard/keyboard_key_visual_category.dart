import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';

/// Categoría visual para colorear teclas (consonante, vocal, palabras, etc.).
enum KeyboardKeyVisualCategory {
  consonant,
  vowel,
  word,
  space,
  dropdownSymbols,
  dropdownNumbers,
  dropdownPhrases,
}

/// Resuelve la categoría a partir del [KeyboardItem] sin tocar cada layout.
KeyboardKeyVisualCategory keyboardKeyVisualCategoryFor(KeyboardItem item) {
  switch (item.type) {
    case KeyboardItemType.dropdown:
      return _categoryForDropdownTitle(item.title);
    case KeyboardItemType.action:
      if (item.title == 'KEYBOARD_phrases') {
        return KeyboardKeyVisualCategory.dropdownPhrases;
      }
      return KeyboardKeyVisualCategory.word;
    case KeyboardItemType.char:
      return _categoryForCharLabel(item.label);
  }
}

KeyboardKeyVisualCategory _categoryForDropdownTitle(String? title) {
  switch (title) {
    case 'KEYBOARD_symbols':
      return KeyboardKeyVisualCategory.dropdownSymbols;
    case 'KEYBOARD_numbers':
      return KeyboardKeyVisualCategory.dropdownNumbers;
    case 'KEYBOARD_phrases':
      return KeyboardKeyVisualCategory.dropdownPhrases;
    default:
      return KeyboardKeyVisualCategory.dropdownSymbols;
  }
}

KeyboardKeyVisualCategory _categoryForCharLabel(String label) {
  final trimmed = label.trim();
  if (trimmed.isEmpty) {
    return KeyboardKeyVisualCategory.space;
  }
  // Espacio ancho u otros rellenos solo con espacios
  if (trimmed.replaceAll(' ', '').isEmpty) {
    return KeyboardKeyVisualCategory.space;
  }

  // Palabras fijas (Sí/No/Yes)
  if (label == 'Sí' || label == 'No' || label == 'Yes') {
    return KeyboardKeyVisualCategory.word;
  }

  // Secuencias tipo ll, rr, qu → mismo tono que consonantes
  if (label.length > 1) {
    return KeyboardKeyVisualCategory.consonant;
  }

  final ch = label.toLowerCase();
  if (ch.length == 1 && 'aeiou'.contains(ch)) {
    return KeyboardKeyVisualCategory.vowel;
  }

  return KeyboardKeyVisualCategory.consonant;
}
