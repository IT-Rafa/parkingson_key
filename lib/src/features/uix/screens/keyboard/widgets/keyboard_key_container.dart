import 'package:flutter/material.dart';

class KeyboardKeyContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final int flex;

  const KeyboardKeyContainer({
    super.key,
    required this.child,
    this.onTap,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: SizedBox.expand(
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
