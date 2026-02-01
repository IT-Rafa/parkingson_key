import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_type_provider.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_type_enum.dart';

class KeyboardDesignSection extends ConsumerWidget {
  const KeyboardDesignSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyboardType = ref.watch(keyboardTypeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "SETTINGS_keyboard_type",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ).tr(),
        const SizedBox(height: 10),
        RadioGroup<KeyboardType>(
          groupValue: keyboardType,
          onChanged: (value) {
            if (value != null) {
              ref.read(keyboardTypeProvider.notifier).setType(value);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: KeyboardType.values.map((type) {
              final isSelected = type == keyboardType;
              return InkWell(
                onTap: () =>
                    ref.read(keyboardTypeProvider.notifier).setType(type),
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<KeyboardType>(
                        value: type,
                      ),
                      Text(
                        _labelForKeyboardType(type),
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _labelForKeyboardType(KeyboardType type) {
    switch (type) {
      case KeyboardType.qwerty:
        return 'QWERTY';
      case KeyboardType.abc:
        return 'ABC';
      case KeyboardType.consonantsVowels:
        return 'Consonantes / Vocales';
    }
  }
}
