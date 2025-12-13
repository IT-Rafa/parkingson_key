import 'package:flutter/material.dart';

enum KeyboardItemType { char, action, dropdown, spacer }

class KeyboardItem {
  final KeyboardItemType type;
  final String? label;
  final String? title; // para dropdown
  final List<String>? items;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final int flex;

  const KeyboardItem._({
    required this.type,
    this.label,
    this.title,
    this.items,
    this.initialValue,
    this.onChanged,
    this.flex = 1,
  });

  factory KeyboardItem.char(String label, {int flex = 1}) =>
      KeyboardItem._(type: KeyboardItemType.char, label: label, flex: flex);

  factory KeyboardItem.action(String label, {int flex = 1}) =>
      KeyboardItem._(type: KeyboardItemType.action, label: label, flex: flex);

  factory KeyboardItem.dropdown({
    required String title,
    required List<String> items,
    String? initialValue,
    ValueChanged<String?>? onChanged,
    int flex = 1,
  }) =>
      KeyboardItem._(
        type: KeyboardItemType.dropdown,
        title: title,
        items: items,
        initialValue: initialValue,
        onChanged: onChanged,
        flex: flex,
      );

  factory KeyboardItem.spacer({int flex = 1}) =>
      KeyboardItem._(type: KeyboardItemType.spacer, flex: flex);
}
