import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_base.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_port_header.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/numbers_dropdown.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/phrases_dropdown.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/settings_menu.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/symbols_dropdown.dart';

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
    final orientation = MediaQuery.of(context).orientation;
    final layout = ref.watch(keyboardProvider(orientation));

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

              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: KeyboardPortHeader(
                      controller: _controller,
                      focusNode: _focusNode,
                    ),
                  ),

                  // ---------- BOTONES + TECLADO SEGÚN ORIENTACIÓN ----------
                  Expanded(
                    child: isPortrait
                        ? Column(
                            children: [
                              // ⭐ Botones encima del teclado
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
                                  children: [
                                    _iconLabelButton(Icons.save, "Guardar"),
                                    _iconLabelButton(Icons.send, "Enviar"),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Card(
                                  color: Colors.grey,
                                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: KeyboardBase(
                                    layout: layout,
                                    onKeyPressed: _insertText,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              // Teclado ocupa casi todo
                              Expanded(
                                child: Card(
                                  color: Colors.grey,
                                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: KeyboardBase(
                                    layout: layout,
                                    onKeyPressed: _insertText,
                                  ),
                                ),
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

                                    children: [
                                      _iconLabelButton(Icons.save, "Guardar"),
                                      _iconLabelButton(Icons.send, "Enviar"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),

                  // ----------- DROPDOWNS -----------
                  Card(
                    margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    color: Colors.indigo.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: NumbersDropdown(onSelected: _insertText),
                          ),
                          Expanded(
                            child: SymbolsDropdown(onSelected: _insertText),
                          ),
                          Expanded(
                            child: PhrasesDropdown(
                              phrases: const [
                                "¿En qué puedo ayudarte?",
                                "Voy hacia allí",
                                "Gracias",
                              ],
                              onSelected: _insertText,
                            ),
                          ),
                        ],
                      ),
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
        width: 65, // ancho suficiente para que el texto no rompa mal
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Icon(icon, size: 20),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
