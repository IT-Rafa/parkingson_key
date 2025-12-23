import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/landscape_layout.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/portrait_layout.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/settings_menu.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/textfield_row.dart';

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
                actions: const [SettingsMenu()],
              )
            : null,
            
        body: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            return Column(
              children: [
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
                Expanded(
                  child: isPortrait
                      ? PortraitLayout(onInsertText: _insertText)
                      : LandscapeLayout(onInsertText: _insertText),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
