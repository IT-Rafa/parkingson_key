import 'package:flutter/material.dart';

class PhrasesMenuAnchor extends StatefulWidget {
  const PhrasesMenuAnchor({
    super.key,
    required this.phrases,
    required this.onSelected,
  });

  final List<String> phrases;
  final ValueChanged<String> onSelected;

  @override
  State<PhrasesMenuAnchor> createState() => _PhrasesMenuAnchorState();
}

class _PhrasesMenuAnchorState extends State<PhrasesMenuAnchor> {
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
          child: Text(
            phrase,
            softWrap: true,
            style: TextStyle(fontSize: 20, height: 1.2),
          ),
        );
      }).toList(),

      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),

        onPressed: () {
          _controller.open();
        },
        label: const Text('Frases', textAlign: TextAlign.center),
        icon: const Icon(Icons.arrow_drop_down),
        iconAlignment: IconAlignment.end,
      ),
    );
  }
}
