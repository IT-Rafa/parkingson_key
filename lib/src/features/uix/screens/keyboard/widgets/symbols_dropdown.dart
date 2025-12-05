import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/base_dropdown_box.dart';

class SymbolsDropdown extends StatelessWidget {
  final ValueChanged<String> onSelected;

  const SymbolsDropdown({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    const symbols = [
      ".",
      ",",
      ":",
      ";",
      "?",
      "!",
      "-",
      "_",
      "@",
      "#",
      "%",
      "&",
      "/",
      "+",
      "*",
    ];

    return BaseDropdownBox(
      title: "KEYBOARD_symbols".tr(),
      items: symbols
          .map(
            (s) => DropdownMenuItem(
              value: s,
              child: Text(s, style: const TextStyle(fontSize: 18)),
            ),
          )
          .toList(),
      onSelected: onSelected,
      orientation: orientation,
    );
  }
}
