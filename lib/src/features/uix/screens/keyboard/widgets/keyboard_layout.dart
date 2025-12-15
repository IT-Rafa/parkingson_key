import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_row.dart';
import 'package:parkingson_key/src/models/keyboard_item.dart';

class KeyboardLayout extends StatelessWidget {
  final List<List<KeyboardItem>> layout;

  const KeyboardLayout({super.key, required this.layout});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: layout
            .map((row) => Expanded(flex: 1, child: KeyboardRow(items: row)))
            .toList(),
      ),
    );
  }
}
