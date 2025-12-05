import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/base_dropdown_box.dart';

class NumbersDropdown extends StatelessWidget {
  final ValueChanged<String> onSelected;

  const NumbersDropdown({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    final orientation = MediaQuery.of(context).orientation;

    return BaseDropdownBox(
      title: "KEYBOARD_numbers".tr(),
      items: numbers
          .map((n) => DropdownMenuItem(value: n, child: Text(n)))
          .toList(),
      onSelected: onSelected,
      orientation: orientation,
    );
  }
}
