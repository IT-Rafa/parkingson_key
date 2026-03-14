import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/providers/tts_service_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/textfield_row/utils/delete_all.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/textfield_row/utils/delete_char.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/textfield_row/utils/delete_word.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';

class TextFieldBase extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const TextFieldBase({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  ConsumerState<TextFieldBase> createState() => _TextFieldBaseState();
}

class _TextFieldBaseState extends ConsumerState<TextFieldBase> {
  KeyboardAccessibilityProfile get profile => ref.read(keyboardProfileProvider);

  @override
  Widget build(BuildContext context) {
    final ttsService = ref.read(ttsServiceProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: widget.controller,
                readOnly: true,
                showCursor: true,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87, width: 1.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87, width: 1.5),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () {
                      ttsService.speak(widget.controller.text);
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          PopupMenuButton<String>(
            tooltip: "KEYBOARD_delete".tr(),
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ],
              ),
            ),
            onSelected: (value) {
              switch (value) {
                case 'delete_char':
                  deleteChar(widget.controller);
                  break;

                case 'delete_word':
                  deleteWord(widget.controller);
                  break;

                case 'delete_all':
                  deleteAll(widget.controller);
                  break;
              }

              FeedbackService.accept(
                messenger: ScaffoldMessenger.of(context),
                profile: profile,
              );
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete_char',
                child: Text("KEYBOARD_delete_char").tr(),
              ),
              PopupMenuItem(
                value: 'delete_word',
                child: Text("KEYBOARD_delete_word").tr(),
              ),
              PopupMenuItem(
                value: 'delete_all',
                child: Text("KEYBOARD_delete_all").tr(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
