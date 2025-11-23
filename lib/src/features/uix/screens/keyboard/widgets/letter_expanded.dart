import 'package:flutter/material.dart';

class LetterExpanded extends StatelessWidget {
  const LetterExpanded({
    super.key,
    required TextEditingController controller,
    required this.letter,
    required this.toWrite,
    this.abreviation,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String letter;
  final String toWrite;

  final String? abreviation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          _controller.text += toWrite;
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(60, 30),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 100) {
              // Para pantallas más pequeñas, usa una palabra corta
              return Text(abreviation ?? letter);
            } else {
              // Para pantallas más anchas, usa una palabra más larga
              return Text(letter);
            }
          },
        ),
      ),
    );
  }
}
