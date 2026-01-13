import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/keyboard_key_container.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:vibration/vibration.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/accept_on_hold.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';

class KeyboardDropdownKey extends ConsumerStatefulWidget {
  const KeyboardDropdownKey({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    this.color,
  });

  final String title;
  final List<String> items;
  final ValueChanged<String?>? onSelected;
  final Color? color;

  @override
  ConsumerState<KeyboardDropdownKey> createState() =>
      _KeyboardDropdownKeyState();
}

class _KeyboardDropdownKeyState extends ConsumerState<KeyboardDropdownKey> {
  final accept = AcceptOnHold(); // controla la pulsación prolongada
  final GlobalKey _key = GlobalKey();

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
      items: widget.items
          .map((e) => PopupMenuItem(value: e, child: Text(e)))
          .toList(),
    );

    if (selected != null) {
      widget.onSelected?.call(selected);

      // vibración al aceptar
      final profile = ref.read(keyboardProfileProvider);
      if (profile.hapticEnabled) {
        Vibration.vibrate(
          duration: 50,
          amplitude: profile.hapticLevel == HapticLevel.strong ? 255 : 100,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(keyboardProfileProvider);

    return GestureDetector(
      key: _key,
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        // inicia temporizador de pulsación
        accept.start(
          onAccept: _openMenu,
          duration: profile.acceptHoldDuration,
        );
      },
      onTapUp: (_) => accept.cancel(),
      onTapCancel: () => accept.cancel(),
      child: Container(
        height: 50,
        margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        decoration: BoxDecoration(
          color: widget.color ?? Colors.green[400],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: KeyboardKeyContainer(
          color: widget.color,
          child: Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
