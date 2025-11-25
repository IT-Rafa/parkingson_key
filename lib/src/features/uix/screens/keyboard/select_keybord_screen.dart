

import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_land_screen.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_port_screen.dart';

class SelectKeybordScreen extends StatelessWidget {
  const SelectKeybordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: orientation == Orientation.portrait
              ? const KeyboardPortScreen()
              : const KeyboardLandScreen(),
        );
      },
    );
  }
}
