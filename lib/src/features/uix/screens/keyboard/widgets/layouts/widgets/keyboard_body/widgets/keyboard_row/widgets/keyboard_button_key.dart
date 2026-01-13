import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/accept_on_hold.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/keyboard_key_container.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:vibration/vibration.dart';

class KeyboardButtonKey extends ConsumerStatefulWidget {
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
  ConsumerState<KeyboardButtonKey> createState() => _KeyboardButtonKeyState();
}

class _KeyboardButtonKeyState extends ConsumerState<KeyboardButtonKey> {
  final accept = AcceptOnHold();

  @override
  void dispose() {
    accept.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lee el perfil activo del usuario
    final profile = ref.watch(keyboardProfileProvider);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        accept.start(
          onAccept: () {
            widget.onAccepted();

            if (profile.hapticEnabled) {
              Vibration.vibrate(
                duration: 50,
                amplitude: profile.hapticLevel == HapticLevel.strong
                    ? 255
                    : 100,
              );
            }
          },
          duration: profile.acceptHoldDuration,
        );
      },
      onTapUp: (_) => accept.cancel(),
      onTapCancel: () => accept.cancel(),
      child: KeyboardKeyContainer(
        color: widget.color,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final baseFontSize = constraints.maxHeight * 0.80;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
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
