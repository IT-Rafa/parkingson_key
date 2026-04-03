import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum KeyboardItemType {
  char,
  action,
}

class KeyboardItem {
  final KeyboardItemType type;
  final String label; // char
  final String? title; // action identifier
  final VoidCallback? onTap;

  const KeyboardItem._({
    required this.type,
    required this.label,
    this.title,

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
 
  /// 🔑 Texto a mostrar en la UI, traducible
  String get displayText {
    switch (type) {
      case KeyboardItemType.char:
        return label;


      case KeyboardItemType.action:
        return title?.tr() ?? "";
    }
  }
}
