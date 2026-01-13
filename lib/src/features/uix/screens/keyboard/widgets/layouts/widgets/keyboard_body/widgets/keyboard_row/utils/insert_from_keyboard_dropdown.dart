import 'package:flutter/material.dart';

void insertFromKeyboardDropdown(
  TextEditingController controller,
  String value,
) {
  if (value.isEmpty) return;

  controller.value = controller.value.copyWith(
    text: controller.text + value,
    selection: TextSelection.collapsed(
      offset: controller.text.length + value.length,
    ),
  );
}
