import 'package:flutter/material.dart';

void insertFromKeyboardChar(
  TextEditingController controller,
  String char,
) {
  if (char.isEmpty) return;

  final newText = controller.text + char;

  controller.text = newText;
  controller.selection = TextSelection.collapsed(offset: newText.length);
}
