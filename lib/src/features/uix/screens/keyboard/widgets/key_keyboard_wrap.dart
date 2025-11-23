import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/letter_expanded.dart';

class KeyKeyboardWrap extends StatelessWidget {
  const KeyKeyboardWrap({super.key, required TextEditingController controller})
    : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        Row(
          spacing: 5,
          children: [
            LetterExpanded(controller: _controller, letter: "B", toWrite: "b"),
            LetterExpanded(controller: _controller, letter: "C", toWrite: "c"),
            LetterExpanded(controller: _controller, letter: "D", toWrite: "d"),
            LetterExpanded(controller: _controller, letter: "F", toWrite: "f"),
            LetterExpanded(controller: _controller, letter: "G", toWrite: "g"),
            LetterExpanded(controller: _controller, letter: "H", toWrite: "h"),
            LetterExpanded(controller: _controller, letter: "J", toWrite: "j"),
            LetterExpanded(controller: _controller, letter: "K", toWrite: "k"),
          ],
        ),
        Row(
          spacing: 5,
          children: [
            LetterExpanded(controller: _controller, letter: "L", toWrite: "l"),
            LetterExpanded(
              controller: _controller,
              letter: "LL",
              toWrite: "ll",
            ),
            LetterExpanded(controller: _controller, letter: "M", toWrite: "m"),
            LetterExpanded(controller: _controller, letter: "N", toWrite: "n"),
            LetterExpanded(controller: _controller, letter: "Ñ", toWrite: "ñ"),
            LetterExpanded(controller: _controller, letter: "P", toWrite: "p"),
            LetterExpanded(controller: _controller, letter: "Q", toWrite: "q"),
            LetterExpanded(
              controller: _controller,
              letter: "QU",
              toWrite: "qu",
            ),
          ],
        ),
        Row(
          spacing: 5,
          children: [
            LetterExpanded(controller: _controller, letter: "R", toWrite: "r"),
            LetterExpanded(
              controller: _controller,
              letter: "RR",
              toWrite: "rr",
            ),
            LetterExpanded(controller: _controller, letter: "S", toWrite: "s"),
            LetterExpanded(controller: _controller, letter: "T", toWrite: "t"),
            LetterExpanded(controller: _controller, letter: "V", toWrite: "v"),
            LetterExpanded(controller: _controller, letter: "W", toWrite: "w"),
            LetterExpanded(controller: _controller, letter: "X", toWrite: "x"),
            LetterExpanded(controller: _controller, letter: "Y", toWrite: "y"),
            LetterExpanded(controller: _controller, letter: "Z", toWrite: "z"),
          ],
        ),
        Row(
          spacing: 5,
          children: [
            LetterExpanded(controller: _controller, letter: "A", toWrite: "a"),
            LetterExpanded(controller: _controller, letter: "E", toWrite: "e"),
            LetterExpanded(controller: _controller, letter: "I", toWrite: "i"),
            LetterExpanded(controller: _controller, letter: "O", toWrite: "o"),
            LetterExpanded(controller: _controller, letter: "U", toWrite: "u"),
            LetterExpanded(
              controller: _controller,
              letter: "ESPACIO",
              abreviation: "ESP",
              toWrite: " ",
            ),
          ],
        ),
      ],
    );
  }
}
