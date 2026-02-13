import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/build_action_buttons.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/keyboard_body.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';
import 'package:parkingson_key/src/core/controllers/keyboard_repeat_controller.dart';

class PortraitLayout extends StatelessWidget {
  const PortraitLayout({
    super.key,
    required this.layout,
    required this.controller,
    required this.repeatController,
    required this.profile,
  });

  final KeyboardLayout layout;
  final TextEditingController controller;
  final KeyboardRepeatController repeatController;
  final KeyboardAccessibilityProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ActionBar(
          controller: controller,
        ),
        KeyboardBody(
          rows: layout.portrait,
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

class _ActionBar extends ConsumerWidget {
  const _ActionBar({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buildActionButtons(
          context,
          ref: ref,
          controller: controller,
          isPortrait: true,
        ),
      ),
    );
  }
}
