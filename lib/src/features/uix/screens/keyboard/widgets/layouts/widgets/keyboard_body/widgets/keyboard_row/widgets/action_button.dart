import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/accept_on_hold.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/keyboard_key_container.dart';

class ActionButton extends ConsumerStatefulWidget {
  final String title;
  final VoidCallback onAccepted;
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

            FeedbackService.accept(
              messenger: ScaffoldMessenger.of(context),
              profile: profile,
            );
          },
          duration: profile.acceptHoldDuration,
        );
      },
      onTapUp: (_) => accept.cancel(),
      onTapCancel: () => accept.cancel(),
      child: KeyboardKeyContainer(
        color: widget.color ?? Colors.amber, // color base de la tecla

        child: LayoutBuilder(
          builder: (context, constraints) {
            final baseFontSize = constraints.maxHeight * 0.80;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.title.toUpperCase(),
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
