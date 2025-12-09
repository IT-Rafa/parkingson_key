import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/settings_menu.dart';
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
    return Column(
      children: [
        // Row with TextField + Menu Icon
        Row(
          children: [
            // TextField
            Expanded(
              child: SizedBox(
                height: 45,
                child: WriteTextField(widget: widget),
              ),
            ),
            // Menu Icon
            SettingsMenu(),
          ],
        ),

        // Grupo Selector botones + botones
        // Selector + divisor
        Container(
  padding: const EdgeInsets.all(8),
  margin: const EdgeInsets.symmetric(horizontal: 5),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.orange,
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // ---------------- SELECTOR + DIVISOR ----------------
      Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ToggleButtons(
              borderRadius: BorderRadius.circular(6),
              constraints: const BoxConstraints(
                minHeight: 30,
                minWidth: 55,
              ),
              textStyle: const TextStyle(fontSize: 12),
              isSelected: [
                selectedMode == 0,
                selectedMode == 1,
              ],
              onPressed: (index) {
                setState(() => selectedMode = index);
              },
              children: const [
                Text("Borrar"),
                Text("Acción"),
              ],
            ),

            // divisor entre selector y botones
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 2,
              height: 35,
              color: Colors.black26,
            ),
          ],
        ),
      ),

      const SizedBox(width: 10),

      // ---------------- BOTONES A LA DERECHA ----------------
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 12,            // separación entre los botones
            runSpacing: 8,          // por si algún día saltan a otra linea
            children: selectedMode == 0
                ? _deleteButtons()
                : _actionButtons(),
          ),
        ),
      ),
    ],
  ),
)

      ],
    );
  }

  // ---------------- BOTONES BORRAR (icono arriba, texto debajo) ----------------

  List<Widget> _deleteButtons() => [
    _iconLabelButton(Icons.backspace, "Letra"),
    _iconLabelButton(Icons.backspace, "Palabra"),
    _iconLabelButton(Icons.backspace, "Todo"),
  ];

  // ---------------- BOTONES ACCIÓN ----------------

  List<Widget> _actionButtons() => [
    _iconLabelButton(Icons.save, "Guardar"),
    _iconLabelButton(Icons.send, "Enviar"),
  ];

  // ---------------- WIDGET BOTÓN PERSONALIZADO ----------------

  Widget _iconLabelButton(IconData icon, String label) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.limeAccent,
        ),
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
