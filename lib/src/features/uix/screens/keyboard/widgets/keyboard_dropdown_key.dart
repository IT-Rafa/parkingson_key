import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardDropdownKey extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final Color? color;

  const KeyboardDropdownKey({
    super.key,
    required this.title,
    required this.items,
    this.value,
    this.onChanged,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardKeyContainer(
      color: color,
      onTap: () {},
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? title, // 👈 AQUÍ ESTÁ LA CLAVE
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
              value: value,
              isExpanded: true,
              underline: const SizedBox(),
              icon: const SizedBox(),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
