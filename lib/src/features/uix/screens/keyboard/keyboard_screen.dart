import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/textfield_row.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_row.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/phrases_dropdown.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/settings_menu.dart';
import 'package:parkingson_key/src/models/alpha_vowels_keyboard_layout.dart';

class KeyboardScreen extends ConsumerStatefulWidget {
  const KeyboardScreen({super.key});

  @override
  ConsumerState<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends ConsumerState<KeyboardScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _insertText(String value) {
    final newText = _controller.text + value;
    _controller.text = newText;
    _controller.selection = TextSelection.collapsed(offset: newText.length);

    if (!_focusNode.hasFocus) _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _showAppBar
            ? AppBar(
                title: const Text('Parkingson Key'),
                actions: [SettingsMenu()],
              )
            : null,

        body: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            var buttonList = [
              HideTitleButton(),
              SavePhraseButton(),
              SendTextButton(),

              SizedBox(
                width: 85,
                height: 60,
                child: PhrasesDropdown(
                  phrases: const [
                    "¿En qué puedo ayudarte?",
                    "Voy hacia allí",
                    "Gracias",
                  ],
                  onSelected: _insertText,
                ),
              ),
            ];
            return Column(
              children: [
                // TextfieldRow Container
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFieldRow(
                    controller: _controller,
                    focusNode: _focusNode,
                  ),
                ),

                // keyboard and buttons (portrait and lanscape)
                Expanded(
                  child:
                      isPortrait // buttons and below keyboard
                      ? Column(
                          children: [
                            // buttons Container
                            Container(
                              margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: buttonList,
                              ),
                            ),

                            // Keyboard
                            Expanded(
                              // Keyboard Container
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: esAlphaAndVowelsKeyboardLayout
                                      .portrait
                                      .map(
                                        (row) => Expanded(
                                          child: KeyboardRow(items: row),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                            PhrasesDropdown(
                              phrases: const [
                                "¿En qué puedo ayudarte?",
                                "Voy hacia allí",
                                "Gracias",
                              ],
                              onSelected: _insertText,
                            ),
                            PhrasesDropdown(
                              phrases: const [
                                "¿En qué puedo ayudarte?",
                                "Voy hacia allí",
                                "Gracias",
                              ],
                              onSelected: _insertText,
                            ),
                          ],
                        )
                      : Row(
                          // keyboard and buttons to its right
                          children: [
                            // keyboard
                            Expanded(
                              // Keyboard Container
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(8, 4, 0, 8),
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: esAlphaAndVowelsKeyboardLayout
                                      .landscape
                                      .map(
                                        (row) => Expanded(
                                          child: KeyboardRow(items: row),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),

                            // buttons
                            Container(
                              margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: buttonList,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SendTextButton extends StatelessWidget {
  const SendTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      label: SizedBox(
        width: 67, // change width as you need
        height: 47, // change height as you need
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Enviar texto",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14), // change max line you need
          ),
        ),
      ),
    );
  }
}

class SavePhraseButton extends StatelessWidget {
  const SavePhraseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      label: SizedBox(
        width: 67, // change width as you need
        height: 47, // change height as you need
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Guardar frase",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14), // change max line you need
          ),
        ),
      ),
    );
  }
}

class HideTitleButton extends StatelessWidget {
  const HideTitleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      label: SizedBox(
        width: 60, // change width as you need
        height: 47, // change height as you need
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Mostrar título",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14), // change max line you need
          ),
        ),
      ),
    );
  }
}
