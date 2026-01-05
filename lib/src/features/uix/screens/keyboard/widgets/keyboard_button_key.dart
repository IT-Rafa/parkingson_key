
import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/accept_on_hold.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardButtonKey extends StatefulWidget {
  final String label;
  final VoidCallback onAccepted;
  final Color? color;

  const KeyboardButtonKey({
    super.key,
    required this.label,
    required this.onAccepted,
    this.color,
  });

  @override
  State<KeyboardButtonKey> createState() => _KeyboardButtonKeyState();
}

class _KeyboardButtonKeyState extends State<KeyboardButtonKey> {
  final _accept = AcceptOnHold();



  @override
  void dispose() {
    _accept.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _accept.start(onAccept: widget.onAccepted),
      onTapUp: (_) => _accept.cancel(),
      onTapCancel: _accept.cancel,

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
