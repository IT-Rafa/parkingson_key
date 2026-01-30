import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/appbar_visibility_notifier.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/contact_picker.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/phrase_tree_picker.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/keyboard_button_key.dart';

List<Widget> buildActionButtons(
  BuildContext context, {
  required WidgetRef ref,
  required TextEditingController controller,
  required bool isPortrait,
}) {
  final showAppBar = ref.watch(appBarVisibilityProvider);

  Widget keyBox({required Widget child, required bool isPortrait}) {
    return SizedBox(
      width: isPortrait ? 90 : 120,
      height: isPortrait ? 45 : 45,
      child: child,
    );
  }

  return [
    keyBox(
      isPortrait: isPortrait,
      child: KeyboardButtonKey(
        label: showAppBar ? 'appbar_hide'.tr() : 'appbar_show'.tr(),
        onAccepted: () {
          ref.read(appBarVisibilityProvider.notifier).toggle();
        },
      ),
    ),
    keyBox(
      isPortrait: isPortrait,
      child: KeyboardButtonKey(
        label: "Guardar Frase",
        onAccepted: () {
          final text = controller.text;

          if (text.isEmpty) return;

          showModalBottomSheet(
            context: context,
            builder: (_) => PhraseTreePicker(phrase: text),
          );
        },
      ),
    ),
    keyBox(
      isPortrait: isPortrait,
      child: KeyboardButtonKey(
        label: "Enviar texto",
        onAccepted: () {
          final text = controller.text.trim();
          if (text.isEmpty) return;

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => ContactPicker(message: text),
          );
        },
      ),
    ),
    keyBox(
      isPortrait: isPortrait,
      child: KeyboardButtonKey(
        label: "Frases",
        onAccepted: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => PhraseTreePicker(
              // No frase nueva, solo selección
              phrase: null,
              onPhraseSelected: (selected) {
                final newText = controller.text + selected;
                controller.text = newText;
                controller.selection = TextSelection.collapsed(
                  offset: newText.length,
                );
              },
            ),
          );
        },
      ),
    ),
  ];
}
