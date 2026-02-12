import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum KeyboardItemType { char, dropdown }

class KeyboardItem {
  final KeyboardItemType type;
  final String label; // char
  final String? title; // dropdown
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

  factory KeyboardItem.char(String label,
      {Color? lightColor, Color? darkColor}) {
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
    Color? lightColor,
    Color? darkColor,
  }) =>
      KeyboardItem._(
        type: KeyboardItemType.dropdown,
        label: "",
        title: title,
        items: items,
        initialValue: initialValue,
        onChanged: onChanged,
        lightColor: lightColor,
        darkColor: darkColor,
      );

  /// 🔑 Texto a mostrar en la UI, traducible
  String get displayText {
    switch (type) {
      case KeyboardItemType.char:
        return label;
      case KeyboardItemType.dropdown:
        return title?.tr() ?? "";
    }
  }
}
