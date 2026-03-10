import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum KeyboardItemType {
  char,
  dropdown,
  action,
}

class KeyboardItem {
  final KeyboardItemType type;
  final String label; // char
  final String? title; // dropdown
  final List<String>? items;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onTap;

  const KeyboardItem._({
    required this.type,
    required this.label,
    this.title,
    this.items,
    this.initialValue,
    this.onChanged,
    this.onTap,
  });

  factory KeyboardItem.char(String label) {
    return KeyboardItem._(
      type: KeyboardItemType.char,
      label: label,
    );
  }
  factory KeyboardItem.action({
    required String title,
    VoidCallback? onTap,

  }) {
    return KeyboardItem._(
      type: KeyboardItemType.action,
      label: "",
      title: title,
      onTap: onTap,
    );
  }
  factory KeyboardItem.dropdown({
    required String title,
    required List<String> items,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) =>
      KeyboardItem._(
        type: KeyboardItemType.dropdown,
        label: "",
        title: title,
        items: items,
        initialValue: initialValue,
        onChanged: onChanged,
      );

  /// 🔑 Texto a mostrar en la UI, traducible
  String get displayText {
    switch (type) {
      case KeyboardItemType.char:
        return label;

      case KeyboardItemType.dropdown:
        return title?.tr() ?? "";

      case KeyboardItemType.action:
        return title?.tr() ?? "";
    }
  }
}
