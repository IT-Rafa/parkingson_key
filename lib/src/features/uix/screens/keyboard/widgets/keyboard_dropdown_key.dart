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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final baseFontSize = constraints.maxHeight * 0.32;
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: baseFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                        ),
                      );
                    },
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),

          /// Dropdown invisible
          Positioned.fill(
            child: DropdownButton<String>(
              value: value, 
              isExpanded: true,
              isDense: true,
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
