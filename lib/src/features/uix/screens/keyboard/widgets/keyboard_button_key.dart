import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardButtonKey extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const KeyboardButtonKey({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    Color? lightColor,
    Color? darkColor,
  });

  @override
  State<KeyboardButtonKey> createState() => _KeyboardButtonKeyState();
}

class _KeyboardButtonKeyState extends State<KeyboardButtonKey> {
Timer? _timer;

  void _startPress() {
    _timer = Timer(const Duration(milliseconds: 500), () {
      widget.onPressed(); // ✅ aquí se acepta la tecla
    });
  }

  void _cancelPress() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _startPress(),
      onTapUp: (_) => _cancelPress(),
      onTapCancel: _cancelPress,

      child: KeyboardKeyContainer(
        color: widget.color,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final baseFontSize = constraints.maxHeight * 0.80; // 👈 grande
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FittedBox(
                fit: BoxFit.scaleDown, // 👈 solo reduce
      
                child: Text(
                  widget.label.toUpperCase(),
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
      ),
    );
  }
}
