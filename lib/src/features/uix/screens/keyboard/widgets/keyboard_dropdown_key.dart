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
              isExpanded: true,
              underline: const SizedBox(),
              icon: const SizedBox(),
              items: items.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),

              /// 🔑 ESTO ES CRÍTICO
              selectedItemBuilder: (context) {
                return items.map((e) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final baseFontSize = constraints.maxHeight * 0.32;
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            e,
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: baseFontSize,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList();
              },
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
