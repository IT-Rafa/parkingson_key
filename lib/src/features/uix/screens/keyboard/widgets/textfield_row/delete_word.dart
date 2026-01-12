import 'package:flutter/material.dart';

void deleteWord(TextEditingController controller) {
  final text = controller.text;
  if (text.isEmpty) return;

  int end = text.length;

  // Ignorar espacios finales
  while (end > 0 && text[end - 1] == ' ') {
    end--;
  }

  // Buscar espacio anterior
  int start = end - 1;
  while (start >= 0 && text[start] != ' ') {
    start--;
  }

  final newText = text.substring(0, start + 1);
  controller.text = newText;
  controller.selection = TextSelection.collapsed(offset: newText.length);
}
