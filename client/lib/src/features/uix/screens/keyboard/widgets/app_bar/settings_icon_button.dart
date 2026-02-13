import 'package:flutter/material.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, size: 40),
      onPressed: () => Navigator.pushNamed(context, '/settings'),
    );
  }
}
