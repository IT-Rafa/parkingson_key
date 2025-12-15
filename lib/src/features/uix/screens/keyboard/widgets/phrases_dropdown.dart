import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/base_dropdown_box.dart';

class PhrasesDropdown extends StatelessWidget {
  final List<String> phrases;
  final ValueChanged<String> onSelected;

  const PhrasesDropdown({
    super.key,
    required this.phrases,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return BaseDropdownBox(
      title: "KEYBOARD_phrases".tr(),
      items: phrases
          .map(
            (p) => DropdownMenuItem(
              value: p,
              child: Text(p, maxLines: 4, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onSelected: onSelected,
      orientation: orientation,
    );
  }
}
