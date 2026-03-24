import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/core/services/haptic_feedback_service.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/accept_on_hold.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/keyboard_key_container.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_key_contrast.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_key_palette.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_key_visual_category.dart';

class KeyboardActionKey extends ConsumerStatefulWidget {
  final KeyboardItem keyData;
  final VoidCallback onAccepted;
  final double fontSize;

  const KeyboardActionKey({
    super.key,
    required this.keyData,
    required this.onAccepted,
    required this.fontSize,
  });

  @override
  ConsumerState<KeyboardActionKey> createState() => _KeyboardActionKeyState();
}

class _KeyboardActionKeyState extends ConsumerState<KeyboardActionKey> {
  final accept = AcceptOnHold();
  bool _pressed = false;
  bool _accepted = false;

  void _handleAccept(
      BuildContext context, KeyboardAccessibilityProfile profile) async {
    if (_accepted) return;
    _accepted = true;
    widget.onAccepted();
    try {
      await FeedbackService.accept(
        messenger: ScaffoldMessenger.of(context),
        profile: profile,
      );
    } catch (_) {}
  }

  @override
  void dispose() {
    accept.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(keyboardProfileProvider);
    final category = keyboardKeyVisualCategoryFor(widget.keyData);
    final keyColors = KeyboardKeyPalette.colors(context, category);
    final pressedColor = KeyboardKeyContrast.pressedBackgroundAa(
      baseBackground: keyColors.background,
      foreground: keyColors.foreground,
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        setState(() {
          _pressed = true;
          _accepted = false;
        });
        if (profile.hapticEnabled) HapticFeedbackService.tap(profile);
        accept.start(
          onAccept: () async {
            _handleAccept(context, profile);
            await Future.delayed(Duration.zero);
            if (mounted) setState(() => _pressed = false);
          },
          duration: profile.acceptHoldDuration,
        );
      },
      onTapUp: (_) {
        if (!_accepted) {
          accept.cancel();
        }
        setState(() => _pressed = false);
      },
      onTapCancel: () {
        setState(() => _pressed = false);
        accept.cancel();
      },
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 90),
          child: KeyboardKeyContainer(
            color: _pressed ? pressedColor : keyColors.background,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.keyData.title == 'KEYBOARD_back'
                          ? widget.keyData.displayText.toUpperCase()
                          : "${widget.keyData.displayText.toUpperCase()} ▾",
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.bold,
                        color: keyColors.foreground,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
