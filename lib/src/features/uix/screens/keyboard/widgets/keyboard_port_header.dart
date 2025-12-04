import 'package:flutter/material.dart';

import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_textfield_icons/del_all_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_textfield_icons/del_letter_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_textfield_icons/del_word_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_textfield_icons/read_inkwell.dart';

class KeyboardPortHeader extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const KeyboardPortHeader({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  readOnly: true,
                  showCursor: true,
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.menu, size: 40),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: ReadInkwell(controller: controller)),
            ),
            const SizedBox(width: 10),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DelLetterInkWell(controller: controller),
                  DelWordInkWell(controller: controller),
                  DelAllInkWell(controller: controller),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
