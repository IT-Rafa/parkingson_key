import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_button_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_dropdown_key.dart';
import 'package:parkingson_key/src/models/keyboard_item.dart';

class KeyboardRow extends StatelessWidget {
  final List<KeyboardItem> items;

  const KeyboardRow({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final weights = items.map((item) {
          return _effectiveWeight(item, context);
        }).toList();

        final totalWeight =
            weights.fold<double>(0, (sum, w) => sum + w);

        return Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final weight = weights[index];

            final width =
                constraints.maxWidth * (weight / totalWeight);

            return SizedBox(
              width: width,
              child: _buildItem(item),
            );
          }),
        );
      },
    );
  }

  /// 🔑 AQUÍ está toda la lógica de anchura
  double _effectiveWeight(
    KeyboardItem item,
    BuildContext context,
  ) {
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

      case KeyboardItemType.action:
        return isPortrait ? 1.2 : 1.6;

      case KeyboardItemType.spacer:
        return 0.8;
    }
  }

  Widget _buildItem(KeyboardItem item) {
    switch (item.type) {
      case KeyboardItemType.char:
      case KeyboardItemType.action:
        return KeyboardButtonKey(
          label: item.label!,
          onPressed: () {},
          // aquí NO pasamos flex
        );

      case KeyboardItemType.dropdown:
        return KeyboardDropdownKey(
          title: item.title!,
          items: item.items!,
          onChanged: item.onChanged,
        );

      case KeyboardItemType.spacer:
        return const SizedBox();
    }
  }
}
