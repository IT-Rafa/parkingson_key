import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_type_provider.dart';
import 'package:parkingson_key/src/core/services/haptic_feedback_service.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/utils/insert_from_keyboard_char.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/keyboard_action_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/keyboard_button_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/phrase_grid_picker.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/symbol_group_picker.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_type_enum.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/core/controllers/keyboard_repeat_controller.dart';

class KeyboardRow extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final weights = items.map((item) => _effectiveWeight(item)).toList();
        final totalWeight = weights.fold<double>(0, (sum, w) => sum + w);

        // Calculamos un fontSize base para toda la fila
        final charFontSize = (constraints.maxHeight * 0.8).clamp(18.0, 42.0);
        final controlFontSize =
            (constraints.maxHeight * 0.45).clamp(14.0, 24.0);

        return Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final width = constraints.maxWidth * (weights[index] / totalWeight);

            return SizedBox(
              width: width,
              child: _buildItem(context, ref, item, charFontSize, controlFontSize),
            );
          }),
        );
      },
    );
  }

  Widget _buildItem(
    BuildContext context,
    WidgetRef ref,
    KeyboardItem item,
    double charFontSize,
    double controlFontSize,
  ) {
    switch (item.type) {
      case KeyboardItemType.char:
        return KeyboardButtonKey(
          keyData: item,
          fontSize: charFontSize,
          onAccepted: () {
            insertFromKeyboardChar(controller, item.label);
            if (profile.hapticEnabled) HapticFeedbackService.tap(profile);
          },
        );

 

      case KeyboardItemType.action:
        return KeyboardActionKey(
          keyData: item,
          fontSize: controlFontSize,
          onAccepted: () async {
            if (item.title == "KEYBOARD_phrases") {
              await openPhrasePicker(context, controller);
            } else if (item.title == 'KEYBOARD_symbols') {
              await openSymbolPicker(context, controller);
            } else if (item.title == 'KEYBOARD_numbers') {
              final currentType = ref.read(keyboardTypeProvider);
              if (currentType != KeyboardType.numbers) {
                ref.read(keyboardLastTypeProvider.notifier).state = currentType;
              }
              await ref.read(keyboardTypeProvider.notifier).setType(KeyboardType.numbers);
            } else if (item.title == 'KEYBOARD_back') {
              final lastType = ref.read(keyboardLastTypeProvider);
              final targetType = lastType ?? KeyboardType.consonantsVowels;
              await ref.read(keyboardTypeProvider.notifier).setType(targetType);
              ref.read(keyboardLastTypeProvider.notifier).state = null;
            } else {
              item.onTap?.call();
            }
            if (profile.hapticEnabled) HapticFeedbackService.tap(profile);
          },
        );
    }
  }

  double _effectiveWeight(KeyboardItem item) {
    switch (item.type) {
      case KeyboardItemType.char:
        return isPortrait ? 1.25 : 1.6;

      case KeyboardItemType.action:
        return isPortrait ? 1.35 : 1.8;
    }
  }
}

Future<void> openPhrasePicker(
  BuildContext context,
  TextEditingController controller,
) async {
  final phrase = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => const PhraseGridPicker(),
    ),
  );

  if (phrase != null) {
    controller.text += phrase;
  }
}

Future<void> openSymbolPicker(
  BuildContext context,
  TextEditingController controller,
) async {
  final symbol = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => const SymbolGroupPicker(),
    ),
  );

  if (symbol != null) {
    controller.text += symbol;
  }
}
