import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_base.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_land_header.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_port_header.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/numbers_dropdown.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/phrases_dropdown.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/symbols_dropdown.dart';

class KeyboardScreen extends ConsumerStatefulWidget {
  const KeyboardScreen({super.key});

  @override
  ConsumerState<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends ConsumerState<KeyboardScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // ------ HEADER (portrait/landscape) ------
              if (orientation == Orientation.portrait)
                KeyboardPortHeader(
                  controller: _controller,
                  focusNode: _focusNode,
                )
              else
                KeyboardLandHeader(
                  controller: _controller,
                  focusNode: _focusNode,
                ),
          
              // --------- TECLADO PRINCIPAL ----------
          
                 Expanded(
          
                  child: Card(
                    color: Colors.grey ,
                    child: KeyboardBase(
                      layout: layout,
                      onKeyPressed: _insertText,
                    ),
                  ),
                ),
              
          
              // ----------- BLOQUE DE DROPDOWNS -----------
              Card(
                color: Colors.indigo.shade300,
                elevation: 4,
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
                      Expanded(child: NumbersDropdown(onSelected: _insertText)),
                      Expanded(child: SymbolsDropdown(onSelected: _insertText)),
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
          ),
        ),
      ),
    );
  }
}
