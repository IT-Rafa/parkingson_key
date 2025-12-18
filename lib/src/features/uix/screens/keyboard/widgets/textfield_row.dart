import 'package:flutter/material.dart';

class TextFieldRow extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const TextFieldRow({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<TextFieldRow> createState() => _TextFieldRowState();
}

class _TextFieldRowState extends State<TextFieldRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preparamos el espacio para el TextField
        Expanded(
          // -- Columna con el TextField y los iconos de borrar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- TextField
              SizedBox(
                height: 45,
                child: TextField(
                  controller: widget.controller,
                  readOnly: true,
                  showCursor: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.volume_up),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
              // -
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // -- Icono esconder barra
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                      onPressed: () {},
                      icon: Icon(Icons.touch_app),
                    ),
                  ),

                  // -- Espacio
                  Spacer(),
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

              //- Iconos de borrar
            ],
          ),
        ),
      ],
    );
  }
}
