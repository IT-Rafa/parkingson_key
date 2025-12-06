import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DelWordInkWell extends StatelessWidget {
  const DelWordInkWell({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        deleteLastWord(_controller);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.backspace, color: Colors.blue, size: 18,),
          Text(
            "KEYBOARD_word",
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.black),          ).tr(),
        ],
      ),
    );
  }
}

void deleteLastWord(TextEditingController controller) {
  final text = controller.text.trimRight();

  if (text.isEmpty) {
    return;
  }

  // Buscar el último espacio
  final lastSpace = text.lastIndexOf(' ');

  if (lastSpace == -1) {
    // Si no hay espacios, se borra todo
    controller.text = '';
  } else {
    // Cortar desde el inicio hasta el último espacio
    controller.text = text.substring(0, lastSpace + 1);
  }

  // Mover el cursor al final
  controller.selection = TextSelection.fromPosition(
    TextPosition(offset: controller.text.length),
  );
}