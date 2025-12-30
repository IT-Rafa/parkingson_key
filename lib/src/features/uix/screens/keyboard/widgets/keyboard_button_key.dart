import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardButtonKey extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const KeyboardButtonKey({
    super.key,
    required this.label,
    required this.onPressed,
    this.color, Color? lightColor, Color? darkColor,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardKeyContainer(
      color: color,
      onTap: onPressed,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final baseFontSize = constraints.maxHeight * 0.80; // 👈 grande
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: FittedBox(
              fit: BoxFit.scaleDown, // 👈 solo reduce

              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: baseFontSize,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
