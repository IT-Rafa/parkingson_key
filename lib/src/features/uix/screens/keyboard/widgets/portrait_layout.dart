import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/build_buttons.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_row.dart';
import 'package:parkingson_key/src/models/alpha_vowels_keyboard_layout.dart';

class PortraitLayout  extends ConsumerWidget {
  const PortraitLayout({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonsWidgetList = buildButtons(
      context,
      ref: ref,
      controller: controller,
      isPortrait: false,
    );


    return Column(
      children: [
        // Buttons
        Container(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttonsWidgetList,
          ),
        ),

        // Keyboard
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: esAlphaAndVowelsKeyboardLayout.portrait
                  .map((row) => Expanded(child: KeyboardRow(items: row)))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
