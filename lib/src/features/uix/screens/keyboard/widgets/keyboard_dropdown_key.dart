import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_key_container.dart';

class KeyboardDropdownKey extends StatelessWidget {
  final String title;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final int flex;

  const KeyboardDropdownKey({
    super.key,
    required this.title,
    required this.items,
    this.onChanged,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardKeyContainer(
      flex: flex,
      onTap: () {}, // mantiene ripple
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double fontSize = constraints.maxHeight * 0.5;
                      return Text(
                        title,
                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 28,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              icon: const SizedBox(), // ocultamos icono original
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
