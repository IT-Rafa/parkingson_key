import 'package:flutter/material.dart';

enum KeyboardItemType { char, dropdown }

class KeyboardItem {
  final KeyboardItemType type;
  final String label;
  final String? title; // para dropdown
  final List<String>? items;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final Color? lightColor;
  final Color? darkColor;

  const KeyboardItem._({
    required this.type,
    required this.label,
    this.title,
    this.items,
    this.initialValue,
    this.onChanged,
    this.lightColor,
    this.darkColor,
  });

  factory KeyboardItem.char(
    String label, {
    Color? lightColor,
    Color? darkColor,
  }) {
    return KeyboardItem._(
      type: KeyboardItemType.char,
      label: label,
      lightColor: lightColor,
      darkColor: darkColor,
    );
  }

  factory KeyboardItem.dropdown({
    required String title,
    required List<String> items,
    String? initialValue,
    ValueChanged<String?>? onChanged,
    final Color? lightColor,
    final Color? darkColor,
  }) => KeyboardItem._(
    label: "",
    type: KeyboardItemType.dropdown,
    title: title,
    items: items,
    initialValue: initialValue,
    onChanged: onChanged,
    lightColor: lightColor,
    darkColor: darkColor,
  );
}
