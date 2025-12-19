import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardDropdownKey extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final Color? color;

  const KeyboardDropdownKey({
    super.key,
    required this.title,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.color,
  });

  @override
  State<KeyboardDropdownKey> createState() => _KeyboardDropdownKeyState();
}

class _KeyboardDropdownKeyState extends State<KeyboardDropdownKey> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardKeyContainer(
      color: widget.color,
      onTap: () {},
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),

          // DROPDOWN INVISIBLE
          Positioned.fill(
            child: DropdownButton<String>(
              value: widget.initialValue,
              isExpanded: true,
              underline: const SizedBox(),
              icon: const SizedBox(),
              items: widget.items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
