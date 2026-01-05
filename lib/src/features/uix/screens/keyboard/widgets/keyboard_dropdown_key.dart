import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/accept_on_hold.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardDropdownKey extends StatefulWidget {
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
  State<KeyboardDropdownKey> createState() => _KeyboardDropdownKeyState();
}

class _KeyboardDropdownKeyState extends State<KeyboardDropdownKey> {
  final _accept = AcceptOnHold();
  final GlobalKey _key = GlobalKey();

  @override
  void dispose() {
    _accept.dispose();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _accept.start(onAccept: _openMenu),
      onTapUp: (_) => _accept.cancel(),
      onTapCancel: _accept.cancel,

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
