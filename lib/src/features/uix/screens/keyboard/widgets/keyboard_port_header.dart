import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/settings_menu.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/write_text_field.dart';

class KeyboardPortHeader extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const KeyboardPortHeader({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<KeyboardPortHeader> createState() => _KeyboardPortHeaderState();
}

class _KeyboardPortHeaderState extends State<KeyboardPortHeader> {
  int selectedMode = 0; // 0 = BORRAR, 1 = ACCIÓN

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row with TextField + Menu Icon
        Row(
          children: [
            // TextField
            Expanded(
              child: SizedBox(
                height: 45,
                child: WriteTextField(widget: widget),
              ),
            ),
            // Menu Icon
            SettingsMenu(),
          ],
        ),

        // Grupo Selector botones + botones
        // Selector + divisor
      ],
    );
  }
}
