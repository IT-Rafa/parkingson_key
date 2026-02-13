import 'package:flutter/material.dart';

void deleteChar(TextEditingController controller) {
  final text = controller.text;
  if (text.isEmpty) return;

  final newText = text.substring(0, text.length - 1);
  controller.text = newText;
  controller.selection = TextSelection.collapsed(offset: newText.length);
}
