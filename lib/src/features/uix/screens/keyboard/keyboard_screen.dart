import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_layout.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_port_header.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/phrases_dropdown.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/settings_menu.dart';
import 'package:parkingson_key/src/models/keyboard_layout.dart';

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

        body: GestureDetector(
          onTap: _toggleAppBarVisibility,
          child: OrientationBuilder(
            builder: (context, orientation) {
              final isPortrait = orientation == Orientation.portrait;

              var buttonList = [
                _iconLabelButton(Icons.save, "Guardar"),
                _iconLabelButton(Icons.send, "Enviar"),

                SizedBox(
                  width: 100,
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
                  // Contenedor de
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: KeyboardPortHeader(
                      controller: _controller,
                      focusNode: _focusNode,
                    ),
                  ),
                  Expanded(
                    child: isPortrait
                        ? Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                padding: const EdgeInsets.all(8),
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

                              // teclado
                              Expanded(
                                child: KeyboardLayout(layout: keyboardLayout),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              // teclado
                              Expanded(
                                child: KeyboardLayout(layout: keyboardLayout),
                              ),

                              // ⭐ Botones a la derecha del teclado
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                padding: const EdgeInsets.all(8),

                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: buttonList,
                                  ),
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
        width: 100, // ancho suficiente para que el texto no rompa mal
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
