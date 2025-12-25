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
                height: 1.2, 
              ),
            ),
          ),
        );
      }).toList(),

      child: TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        onPressed: () {
          _controller.open();
        },
        icon: const Icon(Icons.arrow_drop_down),
        iconAlignment: IconAlignment.end,
        label: const Text('Frases', textAlign: TextAlign.center),
      ),
    );
  }
}
