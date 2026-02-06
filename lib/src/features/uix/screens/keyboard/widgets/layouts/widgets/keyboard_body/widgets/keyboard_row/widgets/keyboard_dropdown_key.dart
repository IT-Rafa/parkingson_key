import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/services/haptic_feedback_service.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/keyboard_key_container.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/accept_on_hold.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';

class KeyboardDropdownKey extends ConsumerStatefulWidget {
  final KeyboardItem keyData;
  final ValueChanged<String?>? onSelected;

  const KeyboardDropdownKey({
    super.key,
    required this.keyData,
    required this.onSelected,
  });

  @override
  ConsumerState<KeyboardDropdownKey> createState() =>
      _KeyboardDropdownKeyState();
}

class _KeyboardDropdownKeyState extends ConsumerState<KeyboardDropdownKey> {
  final GlobalKey _key = GlobalKey();

  final accept = AcceptOnHold();
  bool _pressed = false;

  @override
  void dispose() {
    accept.dispose();
    super.dispose();
  }

  Future<void> _openMenu() async {
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final size = box.size;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height,
        offset.dx + size.width,
        offset.dy,
      ),
      items: widget.keyData.items!
          .map((e) => PopupMenuItem(value: e, child: Text(e.tr())))
          .toList(),
    );

    if (selected != null) {
      widget.onSelected?.call(selected);
      final profile = ref.read(keyboardProfileProvider);
      HapticFeedbackService.tap(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(keyboardProfileProvider);
    final baseColor = widget.keyData.lightColor ?? Colors.amber;

    final pressedColor = Color.alphaBlend(
      Colors.black.withValues(alpha: 0.25),
      baseColor,
    );

    return GestureDetector(
      key: _key,
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        setState(() => _pressed = true);

        accept.start(
          onAccept: _openMenu,
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
        child: Center(
          child: Text(
            widget.keyData.displayText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
