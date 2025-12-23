import 'package:flutter/material.dart';

class PhrasesDropdown extends StatefulWidget {
  const PhrasesDropdown({
    super.key,
    required this.phrases,
    required this.onSelected,
  });

  final List<String> phrases;
  final ValueChanged<String> onSelected;

  @override
  State<PhrasesDropdown> createState() => _PhrasesDropdownState();
}

class _PhrasesDropdownState extends State<PhrasesDropdown> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MenuAnchor(
      controller: _controller,
      style: MenuStyle(
        // 👇 AQUÍ controlas el ancho REAL
        minimumSize: WidgetStateProperty.all(Size(screenWidth * 0.95, 0)),
      ),
      menuChildren: widget.phrases.map((phrase) {
        return MenuItemButton(
          onPressed: () {
            widget.onSelected(phrase);
            _controller.close();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              phrase,
              softWrap: true,
              style: TextStyle(
                fontSize: 15,
                height: 1.2, // 👈 interlineado compacto
              ),
            ),
          ),
        );
      }).toList(),

      // 👇 ESTE es tu botón pequeño
      child: TextButton(
        onPressed: () {
          _controller.open();
        },
        child: const Text('Frases', textAlign: TextAlign.center),
      ),
    );
  }
}
