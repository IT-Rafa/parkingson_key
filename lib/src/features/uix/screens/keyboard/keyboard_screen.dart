import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_all_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_letter_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_word_inkwell.dart';

class KeyboardScreen extends ConsumerStatefulWidget {
  const KeyboardScreen({super.key});

  @override
  ConsumerState<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends ConsumerState<KeyboardScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: _controller,
                      decoration: const InputDecoration(
                        fillColor: Colors.red,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 65,
                  color: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.volume_up, color: Colors.green),
                            Text(
                              "KEYBOARD_read",
                              style: Theme.of(context).textTheme.labelMedium!
                                  .copyWith(color: Colors.green),
                            ).tr(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 65,
                  color: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 30,
                    children: [
                      DelLetterInkWell(controller: _controller),
                      DelWordInkWell(controller: _controller),
                      DelAllInkWell(controller: _controller),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: Icon(Icons.menu, size: 40),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 5.0,
              ),

              child: Wrap(
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      LetterExpanded(
                        controller: _controller,
                        letter: "B",
                        toWrite: "b",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "C",
                        toWrite: "c",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "D",
                        toWrite: "d",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "F",
                        toWrite: "f",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "G",
                        toWrite: "g",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "H",
                        toWrite: "h",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "J",
                        toWrite: "j",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "K",
                        toWrite: "k",
                      ),
                    ],
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      LetterExpanded(
                        controller: _controller,
                        letter: "L",
                        toWrite: "l",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "LL",
                        toWrite: "ll",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "M",
                        toWrite: "m",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "N",
                        toWrite: "n",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "Ñ",
                        toWrite: "Ñ",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "P",
                        toWrite: "p",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "Q",
                        toWrite: "Q",
                      ),
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
                      LetterExpanded(
                        controller: _controller,
                        letter: "R",
                        toWrite: "r",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "RR",
                        toWrite: "rr",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "S",
                        toWrite: "s",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "T",
                        toWrite: "t",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "V",
                        toWrite: "v",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "W",
                        toWrite: "w",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "X",
                        toWrite: "x",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "Y",
                        toWrite: "y",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "Z",
                        toWrite: "z",
                      ),
                    ],
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      LetterExpanded(
                        controller: _controller,
                        letter: "A",
                        toWrite: "a",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "E",
                        toWrite: "e",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "I",
                        toWrite: "i",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "O",
                        toWrite: "o",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "U",
                        toWrite: "u",
                      ),
                      LetterExpanded(
                        controller: _controller,
                        letter: "ESPACIO",
                        toWrite: " ",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                  ),
                  child: Text("KEYBOARD_savePhrase").tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                  ),
                  child: Text("KEYBOARD_sendWhatsApp").tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LetterExpanded extends StatelessWidget {
  const LetterExpanded({
    super.key,
    required TextEditingController controller,
    required this.letter,
    required this.toWrite,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String letter;
  final String toWrite;

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
        child: Text(letter, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
