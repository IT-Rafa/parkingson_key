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
      spacing: 10,

      children: [
        Row(
          spacing: 10,
          children: [
            LetterExpanded(
              controller: widget._controller,
              letter: "B",
              toWrite: "b",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "C",
              toWrite: "c",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "D",
              toWrite: "d",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "F",
              toWrite: "f",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "G",
              toWrite: "g",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "H",
              toWrite: "h",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "J",
              toWrite: "j",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "K",
              toWrite: "k",
            ),
          ],
        ),
        SizedBox(height: 10),

        Row(
          spacing: 10,

          children: [
            LetterExpanded(
              controller: widget._controller,
              letter: "L",
              toWrite: "l",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "LL",
              toWrite: "ll",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "M",
              toWrite: "m",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "N",
              toWrite: "n",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "Ñ",
              toWrite: "ñ",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "P",
              toWrite: "p",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "Q",
              toWrite: "q",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "QU",
              toWrite: "qu",
            ),
          ],
        ),
        SizedBox(height: 10),

        Row(
          spacing: 10,

          children: [
            LetterExpanded(
              controller: widget._controller,
              letter: "R",
              toWrite: "r",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "RR",
              toWrite: "rr",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "S",
              toWrite: "s",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "T",
              toWrite: "t",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "V",
              toWrite: "v",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "W",
              toWrite: "w",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "X",
              toWrite: "x",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "Y",
              toWrite: "y",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "Z",
              toWrite: "z",
            ),
          ],
        ),
        SizedBox(height: 20),

        Row(
          spacing: 10,

          children: [
            LetterExpanded(
              controller: widget._controller,
              letter: "A",
              toWrite: "a",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "E",
              toWrite: "e",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "I",
              toWrite: "i",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "O",
              toWrite: "o",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "U",
              toWrite: "u",
            ),
            LetterExpanded(
              controller: widget._controller,
              letter: "ESPACIO",
              abreviation: "ESP",
              toWrite: " ",
            ),
            Flexible(
              child: PhraseDropdown(phrases: ['Hola', '¿Qué tal?', 'Adiós']),
            ),
          ],
        ),
      ],
    );
  }
}

class PhraseDropdown extends StatefulWidget {
  final List<String> phrases;
  const PhraseDropdown({super.key, required this.phrases});

  @override
  State<PhraseDropdown> createState() => _PhraseDropdownState();
}

class _PhraseDropdownState extends State<PhraseDropdown> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100, // fondo del botón
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
        alignment: Alignment.center,

          value: _selected,
          hint: const Text("Selecciona una frase"),
        
          items: widget.phrases.map((p) {
            return DropdownMenuItem(value: p, child: Text(p));
          }).toList(),
        
          // 👇 ESTA PARTE ES LA CLAVE: SIEMPRE MUESTRA EL MISMO TEXTO
          selectedItemBuilder: (context) {
            return widget.phrases.map((_) {
              return const Text("Selecciona");
            }).toList();
          },
        
          onChanged: (value) {
            setState(() => _selected = value);
          },
        ),
      ),
    );
  }
}
