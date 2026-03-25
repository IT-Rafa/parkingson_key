import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';

/// Categoría visual para colorear teclas (consonante, vocal, palabras, etc.).
enum KeyboardKeyVisualCategory {
  consonant,
  vowel,
  word,
  space,
}

/// Resuelve la categoría a partir del [KeyboardItem] sin tocar cada layout.
KeyboardKeyVisualCategory keyboardKeyVisualCategoryFor(KeyboardItem item) {
  switch (item.type) {
    case KeyboardItemType.action:
      return KeyboardKeyVisualCategory.word;
    case KeyboardItemType.char:
      return _categoryForCharLabel(item.label);
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
