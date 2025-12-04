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
      title: "Phrases",
      items: phrases
          .map(
            (p) => DropdownMenuItem(
              value: p,
              child: Text(p, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onSelected: onSelected,
      orientation: orientation,
    );
  }
}
