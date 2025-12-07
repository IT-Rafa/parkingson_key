import 'package:flutter/material.dart';

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
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  readOnly: true,
                  showCursor: true,
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.volume_up),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.menu, size: 40),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 45,
              child: Chip(
                padding: EdgeInsets.all(2),
                label: Column(
                  children: [
                    Icon(Icons.backspace, size: 18),
                    Text('Letra', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 45,
              child: Chip(
                padding: EdgeInsets.all(2),
                label: Column(
                  children: [
                    Icon(Icons.backspace, size: 18),
                    Text('Palabra', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              height: 45,
              child: Chip(
                padding: EdgeInsets.all(2),
                label: Column(
                  children: [
                    Icon(Icons.backspace, size: 18),
                    Text('Todo', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.menu, size: 40),
            ),
          ],
        ),

        SizedBox(
          width: double.infinity,
          child: Card(
            color: Colors.deepOrange,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  InkWell(
                    child: Chip(
                      label: const Text('Guardar', textAlign: TextAlign.center),
                    ),
                  ),
                  InkWell(
                    child: Chip(
                      label: const Text('Enviar', textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
