import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_land_screen.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_port_screen.dart';

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
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ---- TECLADO ADAPTATIVO ----
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isPortrait =
                      MediaQuery.of(context).orientation ==
                      Orientation.portrait;

                  if (isPortrait) {
                    return KeyboardPortScreen();
                  } else {
                    return KeyboardLandScreen();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
