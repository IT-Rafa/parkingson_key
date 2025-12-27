import 'package:flutter/material.dart';
import 'package:parkingson_key/src/core/services/tts_service.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/delete_all.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/delete_char.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/delete_word.dart';

class TextFieldRow extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const TextFieldRow({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<TextFieldRow> createState() => _TextFieldRowState();
}

class _TextFieldRowState extends State<TextFieldRow> {
  final TtsService _ttsService = TtsService(); // Instancia TTS

  Widget _icon({required IconData icon, required VoidCallback onTap}) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 30,
        onPressed: onTap,
        icon: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- TextField con icono de TTS
              SizedBox(
                height: 35,
                child: TextField(
                  controller: widget.controller,
                  readOnly: true,
                  showCursor: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () {
                        _ttsService.speak(widget.controller.text);
                      },
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
              // -- Iconos de borrado
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _icon(
                    icon: Icons.backspace_outlined,
                    onTap: () => deleteChar(widget.controller),
                  ),
                  _icon(
                    icon: Icons.undo,
                    onTap: () => deleteWord(widget.controller),
                  ),
                  _icon(
                    icon: Icons.delete_forever_outlined,
                    onTap: () => deleteAll(widget.controller),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}