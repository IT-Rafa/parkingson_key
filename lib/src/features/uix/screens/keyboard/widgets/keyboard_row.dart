import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_button_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_dropdown_key.dart';
import 'package:parkingson_key/src/models/keyboard_item.dart';

class KeyboardRow extends StatelessWidget {
  final List<KeyboardItem> items;

  const KeyboardRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final baseWidth = constraints.maxWidth / items.length;

        return Row(
          children: items.map((item) {
            final width = baseWidth * item.flex.clamp(1, 1.5);

            return SizedBox(width: width, child: _buildItem(item));
          }).toList(),
        );
      },
    );
  }

  Widget _buildItem(KeyboardItem item) {
    switch (item.type) {
      case KeyboardItemType.char:
      case KeyboardItemType.action:
        return KeyboardButtonKey(label: item.label!, onPressed: () {});
      case KeyboardItemType.dropdown:
        return KeyboardDropdownKey(
          title: item.title!,
          items: item.items!,
          onChanged: item.onChanged,
        );
      case KeyboardItemType.spacer:
        return const SizedBox();
    }
  }
}
