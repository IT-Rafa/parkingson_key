import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/write_text_field.dart';

class KeyboardPortHeader extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const KeyboardPortHeader({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<KeyboardPortHeader> createState() => _KeyboardPortHeaderState();
}

class _KeyboardPortHeaderState extends State<KeyboardPortHeader> {
  int selectedMode = 0; // 0 = BORRAR, 1 = ACCIÓN

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preparamos el espacio para el TextField
        Expanded(
          // -- Columna con el TextField y los iconos de borrar
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -- TextField
                SizedBox(height: 45, child: WriteTextField(widget: widget)),
                // -- Iconos de borrar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // -- Icono Borrado Caracter
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: () {},
                        icon: Icon(Icons.backspace_outlined),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // -- Icono Borrado Palabra
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: () {},
                        icon: Icon(Icons.undo),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // -- Icono Borrado Total
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: () {},
                        icon: Icon(Icons.delete_forever_outlined),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
     ],
    );
  }
}
