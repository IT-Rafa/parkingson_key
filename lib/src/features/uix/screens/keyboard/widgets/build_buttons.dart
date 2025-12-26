import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/appbar_visibility_notifier.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/app_button.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/phrases_menuanchor.dart';

List<Widget> buildButtons(
  BuildContext context, {
  required WidgetRef ref,

  required TextEditingController controller,
  required bool isPortrait,
}) {
  return [
    AppButton(
      label: "Mostrar título",
      onPressed: () {
        ref.read(appBarVisibilityProvider.notifier).toggle();
      },
    ),

    AppButton(
      label: "Guardar frase",
      onPressed: () {
        final newText = "${controller.text} [TEXTO GUARDADO]";
        controller.text = newText;
        controller.selection = TextSelection.collapsed(offset: newText.length);
      },
    ),
    AppButton(
      label: "Enviar texto",
      onPressed: () {
        final newText = "${controller.text} [TEXTO ENVIADO]";
        controller.text = newText;
        controller.selection = TextSelection.collapsed(offset: newText.length);
      },
    ),

    SizedBox(
      width: isPortrait ? 85 : 112,
      height: isPortrait ? 55 : 35,
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
