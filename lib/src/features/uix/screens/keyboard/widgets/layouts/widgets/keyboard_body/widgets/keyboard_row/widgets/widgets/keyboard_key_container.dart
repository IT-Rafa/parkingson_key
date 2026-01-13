import 'package:flutter/material.dart';

class KeyboardKeyContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  const KeyboardKeyContainer({
    super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor = color ?? theme.colorScheme.surface;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        child: Center(child: child),
      ),
    );
  }
}
