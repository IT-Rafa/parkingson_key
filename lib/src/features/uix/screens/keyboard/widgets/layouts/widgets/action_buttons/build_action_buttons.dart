import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/appbar_visibility_notifier.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/keyboard_button_key.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/phrases_menuanchor.dart';

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
      child:
ElevatedButton(
  onPressed: () {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    ref.read(phraseTreeProvider.notifier).addPhrase(
      selectedCategoryId,
      text,
    );
  },
  child: const Text('Guardar frase'),
);
    ),
    keyBox(
      isPortrait: isPortrait,
      child: KeyboardButtonKey(
        label: "Enviar texto",
        onAccepted: () {
          final newText = "${controller.text} [TEXTO ENVIADO]";
          controller.text = newText;
          controller.selection = TextSelection.collapsed(
            offset: newText.length,
          );
        },
      ),
    ),

    SizedBox(
      width: isPortrait ? 85 : 120,
      height: isPortrait ? 35 : 45,
      child: PhrasesMenuAnchor(
        phrases: const ["¿En qué puedo ayudarte?", "Voy hacia allí", "Gracias"],
        onSelected: (value) {
          final newText = controller.text + value;
          controller.text = newText;
          controller.selection = TextSelection.collapsed(
            offset: newText.length,
          );
        },
      ),
    ),
  ];
}
