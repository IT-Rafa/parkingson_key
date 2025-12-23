import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/build_buttons.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_row.dart';
import 'package:parkingson_key/src/models/alpha_vowels_keyboard_layout.dart';

class LandscapeLayout extends StatelessWidget {
  const LandscapeLayout({super.key, required this.onInsertText});

  final void Function(String) onInsertText;

  @override
  Widget build(BuildContext context) {
    final buttonsWidgetList = buildButtons(context, onInsertText);

    return Row(
      children: [
        // Keyboard
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 0, 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: esAlphaAndVowelsKeyboardLayout.landscape
                  .map((row) => Expanded(child: KeyboardRow(items: row)))
                  .toList(),
            ),
          ),
        ),

        // Buttons
        Container(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttonsWidgetList,
          ),
        ),
      ],
    );
  }
}
