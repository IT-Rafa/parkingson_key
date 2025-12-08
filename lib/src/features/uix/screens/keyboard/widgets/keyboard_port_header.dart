import 'package:flutter/material.dart';

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
        // ---------------- TEXTFIELD + CONFIG ----------------
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  readOnly: true,
                  showCursor: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.volume_up),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.menu, size: 40),
              onPressed: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // ---------------- SELECTOR VERTICAL + BOTONES ----------------
        Row(
          children: [
            // SELECTOR PEQUEÑO VERTICAL
            Column(
              children: [
                // Borrar
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: selectedMode == 0
                          ? Colors.blue.shade100
                          : Colors.grey.shade200,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => setState(() => selectedMode = 0),
                    child: const Text("Borrar", style: TextStyle(fontSize: 15)),
                  ),
                ),
                const SizedBox(height: 4),
                // Acción
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: selectedMode == 1
                          ? Colors.blue.shade100
                          : Colors.grey.shade200,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => setState(() => selectedMode = 1),
                    child: const Text("Acción", style: TextStyle(fontSize: 15)),
                  ),
                ),
              ],
            ),

            Wrap(
              alignment: WrapAlignment.center,
              children: selectedMode == 0 ? _deleteButtons() : _actionButtons(),
            ),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ActionSelector extends StatefulWidget {
  final VoidCallback onDeleteLetter;
  final VoidCallback onDeleteWord;
  final VoidCallback onDeleteAll;

  final VoidCallback onSave;
  final VoidCallback onSend;

  const ActionSelector({
    super.key,
    required this.onDeleteLetter,
    required this.onDeleteWord,
    required this.onDeleteAll,
    required this.onSave,
    required this.onSend,
  });

  @override
  State<ActionSelector> createState() => _ActionSelectorState();
}

class _ActionSelectorState extends State<ActionSelector> {
  int selected = 0; // 0 = borrar, 1 = acción

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SELECTOR VERTICAL CENTRADO
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                _buildSelectorButton("Borrar", Icons.backspace, 0),
                const SizedBox(height: 10),
                _buildSelectorButton("Acción", Icons.settings, 1),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // BOTONES A LA DERECHA — CENTRADOS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: selected == 0 ? _buttonsDelete() : _buttonsAction(),
        ),
      ],
    );
  }

  // -------------------------
  // SELECTOR BUTTON (Título + icono)
  // -------------------------
  Widget _buildSelectorButton(String text, IconData icon, int index) {
    final bool isSelected = selected == index;

    return GestureDetector(
      onTap: () => setState(() => selected = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 26),
            const SizedBox(height: 4),
            Text(text, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // ----------------------------------
  //    BOTONES DE BORRAR
  // ----------------------------------
  List<Widget> _buttonsDelete() {
    return [
      _bigButton(Icons.keyboard_backspace, "Letra", widget.onDeleteLetter),
      const SizedBox(width: 14),
      _bigButton(Icons.subdirectory_arrow_left, "Palabra", widget.onDeleteWord),
      const SizedBox(width: 14),
      _bigButton(Icons.delete_forever, "Todo", widget.onDeleteAll),
    ];
  }

  // ----------------------------------
  //    BOTONES DE ACCIÓN
  // ----------------------------------
  List<Widget> _buttonsAction() {
    return [
      _bigButton(Icons.save, "Guardar", widget.onSave),
      const SizedBox(width: 14),
      _bigButton(Icons.send, "Enviar", widget.onSend),
    ];
  }

  // ----------------------------------
  // BOTÓN GRANDE (Icono + Texto debajo)
  // ----------------------------------
  Widget _bigButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 85, // 👈 ANCHO FIJO PARA QUE NO SE PARTA EL TEXTO
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 32),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
