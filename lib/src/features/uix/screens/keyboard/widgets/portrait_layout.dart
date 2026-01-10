import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_type_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/build_buttons.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_accessibility_profile.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_body.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_layout_resolver.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_repeat_controller.dart';

class PortraitLayout extends ConsumerWidget {
  const PortraitLayout({
    super.key,
    required this.controller,
    required this.repeatController,
    required this.profile,
  });

  final TextEditingController controller;
  final KeyboardRepeatController repeatController;
  final KeyboardAccessibilityProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyboardType = ref.watch(keyboardTypeProvider);
    final layout = resolveKeyboardLayout(keyboardType);

    final buttons = buildButtons(
      context,
      ref: ref,
      controller: controller,
      isPortrait: true,
    );

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons,
          ),
        ),

        KeyboardBody(
          rows: layout.landscape,
          controller: controller,
          isPortrait: true,
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
          repeatController: repeatController,
          profile: profile,
        ),
      ],
    );
  }
}
