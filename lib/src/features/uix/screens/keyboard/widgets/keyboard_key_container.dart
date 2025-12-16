import 'package:flutter/material.dart';

class KeyboardKeyContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;

  const KeyboardKeyContainer({super.key, required this.child, this.onTap, this.color,});

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
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}
