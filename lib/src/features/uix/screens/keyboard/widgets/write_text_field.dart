import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_port_header.dart';

class WriteTextField extends StatelessWidget {
  const WriteTextField({
    super.key,
    required this.widget,
  });

  final KeyboardPortHeader widget;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      showCursor: true,
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.volume_up),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
