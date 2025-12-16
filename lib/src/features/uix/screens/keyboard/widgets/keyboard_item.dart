import 'package:flutter/material.dart';

enum KeyboardItemType { char, dropdown }

class KeyboardItem {
  final KeyboardItemType type;
  final String? label;
  final String? title; // para dropdown
  final List<String>? items;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final Color? color;

  const KeyboardItem._({
    required this.type,
    this.label,
    this.title,
    this.items,
    this.initialValue,
    this.onChanged,
    this.color,
  });

  factory KeyboardItem.char(String label, {Color? color}) {
    return KeyboardItem._(
      type: KeyboardItemType.char,
      label: label,
      color: color,
    );
  }

  factory KeyboardItem.dropdown({
    required String title,
    required List<String> items,
    String? initialValue,
    ValueChanged<String?>? onChanged,
    Color? color,
  }) => KeyboardItem._(
    type: KeyboardItemType.dropdown,
    title: title,
    items: items,
    initialValue: initialValue,
    onChanged: onChanged,
    color: color,
  );
}
