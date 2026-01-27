import 'package:flutter/material.dart';
import 'package:parkingson_key/src/core/services/haptic_feedback_service.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/utils/insert_from_keyboard_char.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/utils/insert_from_keyboard_dropdown.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/keyboard_button_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/keyboard_dropdown_key.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/core/controllers/keyboard_repeat_controller.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    super.key,
    required this.items,
    required this.controller,
    required this.isPortrait,
    required this.repeatController,
    required this.profile,
  });

  final List<KeyboardItem> items;
  final TextEditingController controller;
  final bool isPortrait;
  final KeyboardRepeatController repeatController;
  final KeyboardAccessibilityProfile profile;

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
          onAccepted: () {
            // 1️⃣ bloquea repetición
            if (!repeatController.canAccept(
              item,
              profile.repeatBlockDuration,
            )) {
              return;
            }

            // 2️⃣ inserta el carácter
            insertFromKeyboardChar(controller, item.label!);

            // 3️⃣ feedback háptico si está activado
            if (profile.hapticEnabled) {
              HapticFeedbackService.tap(profile);
            }
          },
        );

      case KeyboardItemType.dropdown:
        return KeyboardDropdownKey(
          title: item.title!,
          items: item.items!,
          onSelected: (value) {
            if (value == null) return;

            if (!repeatController.canAccept(
              item,
              profile.repeatBlockDuration,
            )) {
              return;
            }

            insertFromKeyboardDropdown(controller, value);

            if (profile.hapticEnabled) {
              HapticFeedbackService.tap(profile);
            }
          },
        );
    }
  }
}
