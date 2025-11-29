import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_button.dart';

class KeyboardPortrait extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const KeyboardPortrait({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final keys = ["A","B","C","D","E","F","G","H","I"];

    return Padding(
      padding: const EdgeInsets.all(6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          final int columns = 3;
          final double buttonWidth = (maxWidth - (columns * 8)) / columns;

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: keys.map((key) {
              return SizedBox(
                width: buttonWidth,
                height: 70,
                child: KeyboardButton(
                  label: key,
                  onTap: () {
                    controller.text += key;
                    controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length));
                    focusNode.requestFocus();
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
