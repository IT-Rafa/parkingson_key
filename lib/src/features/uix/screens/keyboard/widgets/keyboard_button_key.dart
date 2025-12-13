import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardButtonKey extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final int flex;

  const KeyboardButtonKey({
    super.key,
    required this.label,
    required this.onPressed,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardKeyContainer(
      flex: flex,
      onTap: onPressed,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double fontSize = constraints.maxHeight * 0.5; // 50% del alto
          return Text(
            label,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
    );
  }
}
