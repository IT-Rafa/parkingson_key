import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_type_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/build_buttons.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_row.dart';
import 'package:parkingson_key/src/models/keyboard_Layouts/es_abcde_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard_Layouts/es_consonants_vowels_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard_Layouts/es_qwerty_keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard_type.dart';

class LandscapeLayout extends ConsumerWidget {
  const LandscapeLayout({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final keyboardType = ref.watch(keyboardTypeProvider);

    final layout = switch (keyboardType) {
      KeyboardType.qwerty => esQwertyKeyboardLayout,
      KeyboardType.abc => esAbcdeKeyboardLayout,
      KeyboardType.consonantsVowels => esConsonantsVowelsKeyboardLayout,
    };
    final buttonsWidgetList = buildButtons(
      context,
      ref: ref,
      controller: controller,
      isPortrait: false,
    );

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
children: layout.landscape
                  .map(
                    (row) => Expanded(
                      child: KeyboardRow(items: row, controller: controller, isPortrait: false, ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),

        // Buttons
        Container(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(224, 224, 224, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttonsWidgetList,
          ),
        ),
      ],
    );
  }
}
