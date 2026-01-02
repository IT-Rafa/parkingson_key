import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardDropdownKey extends StatefulWidget {
  const KeyboardDropdownKey({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    this.color,
    Color? darkColor,
    Color? lightColor,
  });

  final String title;
  final List<String> items;
  final ValueChanged<String?>? onSelected;
  final Color? color;

  @override
  State<KeyboardDropdownKey> createState() => _KeyboardDropdownKeyState();
}

class _KeyboardDropdownKeyState extends State<KeyboardDropdownKey> {
  Timer? _timer;

  void _startAcceptTimer(BuildContext context) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      _openMenu(context);
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  void _openMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final selected = await showMenu<String>(
      context: context,
      position: position,
      items: widget.items
          .map((e) => PopupMenuItem<String>(value: e, child: Text(e)))
          .toList(),
    );

    if (selected != null) {
      widget.onSelected?.call(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _startAcceptTimer(context),
      onTapUp: (_) => _cancelTimer(),
      onTapCancel: _cancelTimer,

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
          child: Center(child: Text(widget.title, textAlign: TextAlign.center)),
        ),
      ),
    );
  }
}
