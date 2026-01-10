import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_accessibility_profile.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_item.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_repeat_controller.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_row.dart';

class KeyboardBody extends StatelessWidget {
  const KeyboardBody({
    super.key,
    required this.rows,
    required this.controller,
    required this.isPortrait,
    required this.margin,
    required this.repeatController,
    required this.profile,
  });

  final KeyboardRepeatController repeatController;
  final KeyboardAccessibilityProfile profile;

  final List<List<KeyboardItem>> rows;
  final TextEditingController controller;
  final bool isPortrait;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: rows
              .map(
                (row) => Expanded(
                  child: KeyboardRow(
                    items: row,
                    controller: controller,
                    isPortrait: isPortrait,
                    repeatController: repeatController,
                    profile: profile,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
