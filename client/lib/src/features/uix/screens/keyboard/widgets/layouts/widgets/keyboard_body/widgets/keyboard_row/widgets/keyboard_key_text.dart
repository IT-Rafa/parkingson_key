import 'package:flutter/material.dart';

class KeyboardKeyText extends StatelessWidget {
  final String text;
  final bool showDropdownArrow;

  const KeyboardKeyText(
    this.text, {
    this.showDropdownArrow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              showDropdownArrow ? "$text ▾" : text,
              style: const TextStyle(
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
