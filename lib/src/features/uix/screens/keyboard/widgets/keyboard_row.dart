import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_button_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_dropdown_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';
import 'package:parkingson_key/src/models/keyboard_item.dart';

class KeyboardRow extends StatelessWidget {
  final List<KeyboardItem> items;

  const KeyboardRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        switch (item.type) {
          case KeyboardItemType.char:
            return KeyboardButtonKey(label: item.label!, onPressed: () {}, flex: item.flex);
          case KeyboardItemType.action:
            return KeyboardButtonKey(label: item.label!, onPressed: () {}, flex: item.flex);
          case KeyboardItemType.dropdown:
            return KeyboardDropdownKey(
              title: item.title!,
              items: item.items!,
              onChanged: item.onChanged,
              flex: item.flex,
            );
          case KeyboardItemType.spacer:
            return KeyboardKeyContainer(flex: item.flex, child: const SizedBox());
        }
      }).toList(),
    );
  }
}
