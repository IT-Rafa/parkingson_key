import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_button_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_dropdown_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_item.dart';

class KeyboardRow extends StatelessWidget {
  final List<KeyboardItem> items;

  const KeyboardRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final weights = items.map((item) {
          return _effectiveWeight(item, context);
        }).toList();

        final totalWeight = weights.fold<double>(0, (sum, w) => sum + w);

        return Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final weight = weights[index];

            final width = constraints.maxWidth * (weight / totalWeight);

            return SizedBox(width: width, child: _buildItem(item));
          }),
        );
      },
    );
  }

  /// 🔑 AQUÍ está toda la lógica de anchura
  double _effectiveWeight(KeyboardItem item, BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    switch (item.type) {
      case KeyboardItemType.char:
        // Letras simples vs dobles
        if ((item.label?.length ?? 0) > 1) {
          return isPortrait ? 1.25 : 1.6;
        }
        return 1;

      case KeyboardItemType.dropdown:
        return isPortrait ? 1.35 : 1.8;
    }
  }

  Widget _buildItem(KeyboardItem item) {
    switch (item.type) {
      case KeyboardItemType.char:
        return KeyboardButtonKey(
          label: item.label!,
          onPressed: () {},
          color: item.color,
        );

      case KeyboardItemType.dropdown:
        return KeyboardDropdownKey(
          title: item.title!,
          items: item.items!,
          value: item.initialValue,
          onChanged: item.onChanged,
          color: item.color,
        );
    }
  }
}
