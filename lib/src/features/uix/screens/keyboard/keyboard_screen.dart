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

  void _toggleAppBarVisibility() {
    setState(() {
      _showAppBar = !_showAppBar;
    });
  }

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

  Widget _toggleAppBarButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: _toggleAppBarVisibility,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          _showAppBar ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Parkingson Key'),
          actions: [SettingsMenu()],
        ),

        body: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            var buttonList = [
              _iconLabelButton(Icons.save, "Guardar"),
              _iconLabelButton(Icons.send, "Enviar"),

              SizedBox(
                width: 85,
                height: 40,
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
                                  children: alphaVowelsKeyboardLayout.portrait
                                      .map(
                                        (row) => Expanded(
                                          child: KeyboardRow(items: row),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
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
                                  children: alphaVowelsKeyboardLayout.landscape
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

  Widget _iconLabelButton(IconData icon, String label) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.limeAccent,
        ),
        height: 40,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
