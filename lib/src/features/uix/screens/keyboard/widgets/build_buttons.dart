import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/app_button.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/phrases_dropdown.dart';

List<Widget> buildButtons(
  BuildContext context,
  void Function(String) onInsertText,
) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  return [
    AppButton(label: "Mostrar título", onPressed: () {}),
    isPortrait ? SizedBox(width: 3) : SizedBox(height: 3),

    AppButton(label: "Guardar frase", onPressed: () {}),
    isPortrait ? SizedBox(width: 3) : SizedBox(height: 3),

    AppButton(label: "Enviar texto", onPressed: () {}),
    isPortrait ? SizedBox(width: 3) : SizedBox(height: 3),

    SizedBox(
      width: isPortrait ? 90 : 100,
      height: isPortrait ? 60 : 100,
      child: PhrasesDropdown(
        phrases: const ["¿En qué puedo ayudarte?", "Voy hacia allí", "Gracias"],
        onSelected: onInsertText,
      ),
    ),
  ];
}
