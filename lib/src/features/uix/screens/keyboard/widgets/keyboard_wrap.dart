import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/letter_expanded.dart';

class KeyboardWrap extends StatefulWidget {
  const KeyboardWrap({super.key, required TextEditingController controller})
    : _controller = controller;

  final TextEditingController _controller;

  @override
  State<KeyboardWrap> createState() => _KeyboardWrapState();
}

class _KeyboardWrapState extends State<KeyboardWrap> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,

      children: [
        Row(
          spacing: 5,
          children: [
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "B",
                toWrite: "b",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "C",
                toWrite: "c",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "D",
                toWrite: "d",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "F",
                toWrite: "f",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "G",
                toWrite: "g",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "H",
                toWrite: "h",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "J",
                toWrite: "j",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "K",
                toWrite: "k",
              ),
            ),
          ],
        ),
        SizedBox(height: 5),

        Row(
          spacing: 5,

          children: [
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "L",
                toWrite: "l",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "LL",
                toWrite: "ll",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "M",
                toWrite: "m",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "N",
                toWrite: "n",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "Ñ",
                toWrite: "ñ",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "P",
                toWrite: "p",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "Q",
                toWrite: "q",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "QU",
                toWrite: "qu",
              ),
            ),
          ],
        ),
        SizedBox(height: 5),

        Row(
          spacing: 5,

          children: [
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "R",
                toWrite: "r",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "RR",
                toWrite: "rr",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "S",
                toWrite: "s",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "T",
                toWrite: "t",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "V",
                toWrite: "v",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "W",
                toWrite: "w",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "X",
                toWrite: "x",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "Y",
                toWrite: "y",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "Z",
                toWrite: "z",
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        Row(
          spacing: 5,
          children: [
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "A",
                toWrite: "a",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "E",
                toWrite: "e",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "I",
                toWrite: "i",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "O",
                toWrite: "o",
              ),
            ),
            Expanded(
              child: LetterButton(
                controller: widget._controller,
                letter: "U",
                toWrite: "u",
              ),
            ),
            Expanded(
              flex: 2,
              child: LetterButton(
                controller: widget._controller,
                letter: "ESPACIO",
                abreviation: "ESP",
                toWrite: " ",
              ),
            ),

            Flexible(
              flex: 2,
              child: PhraseDropdown(
                title: "Números",
                phrases: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
                controller: widget._controller,
              ),
            ),
            Flexible(
              flex: 2,
              child: PhraseDropdown(
                title: "Símbolos",
                phrases: [
                  '¿',
                  '?',
                  '¡',
                  '!',
                  '.',
                  ',',
                  ':',
                  ';',
                  'º',
                  'ª',
                  '-',
                  '_',
                  '@',
                  '#',
                  '\$',
                  '%',
                  '&',
                  '*',
                ],
                controller: widget._controller,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PhraseDropdown extends StatefulWidget {
  final List<String> phrases;
  final String title;
  final TextEditingController controller;
  const PhraseDropdown({
    super.key,
    required this.phrases,
    required this.title,
    required this.controller,
  });

  @override
  State<PhraseDropdown> createState() => _PhraseDropdownState();
}

class _PhraseDropdownState extends State<PhraseDropdown> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepOrange, // fondo del botón
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          alignment: Alignment.center,

          value: _selected,
          hint: Text(widget.title),

          items: widget.phrases.map((p) {
            return DropdownMenuItem(value: p, child: Text(p));
          }).toList(),

          selectedItemBuilder: (context) {
            return widget.phrases.map((_) {
              return Text(widget.title);
            }).toList();
          },

          onChanged: (value) {
            setState(() => widget.controller.text += value!);
          },
        ),
      ),
    );
  }
}
