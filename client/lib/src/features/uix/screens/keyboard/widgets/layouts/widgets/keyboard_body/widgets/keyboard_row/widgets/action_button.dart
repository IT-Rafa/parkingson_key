import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/core/services/haptic_feedback_service.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/accept_on_hold.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/keyboard_key_container.dart';

class ActionButton extends ConsumerStatefulWidget {
  final String title;
  final FutureOr<void> Function() onAccepted;
  final Color? color;

  const ActionButton({
    super.key,
    required this.title,
    required this.onAccepted,
    this.color,
  });

  @override
  ConsumerState<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends ConsumerState<ActionButton> {
  final accept = AcceptOnHold();
  bool _pressed = false;

  @override
  void dispose() {
    accept.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lee el perfil activo del usuario
    final profile = ref.watch(keyboardProfileProvider);

    final baseColor = widget.color ?? Colors.amber;
    final pressedColor = Color.alphaBlend(
      Colors.black.withValues(alpha: 0.25),
      baseColor,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        setState(() => _pressed = true);
        if (profile.hapticEnabled) HapticFeedbackService.tap(profile);
        final messenger = ScaffoldMessenger.of(context);

        accept.start(
          onAccept: () async {
            await widget.onAccepted();
            await Future.delayed(Duration.zero);
            if (mounted) setState(() => _pressed = false);

            FeedbackService.accept(
              messenger: messenger,
              profile: profile,
            );
          },
          duration: profile.acceptHoldDuration,
        );
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        accept.cancel();
      },
      onTapCancel: () {
        setState(() => _pressed = false);
        accept.cancel();
      },
      child: KeyboardKeyContainer(
        color: _pressed ? pressedColor : baseColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}
