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
  Widget _icon({
    required IconData icon,
    required double containerSize,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 20,
        onPressed: onTap,
        icon: Icon(icon),
      ),
    );
  }

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
                height: 35,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // -- Icono Borrado Caracter
                  // ⌫ borrar carácter
                  _icon(
                    icon: Icons.backspace_outlined,
                    onTap: () {},
                    containerSize: 28,
                  ),
                  // ↩ borrar palabra
                  _icon(icon: Icons.undo, onTap: () {}, containerSize: 32),
                  // 🗑 borrar todo
                  _icon(
                    icon: Icons.delete_forever_outlined,
                    onTap: () {},
                    containerSize: 32,
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
