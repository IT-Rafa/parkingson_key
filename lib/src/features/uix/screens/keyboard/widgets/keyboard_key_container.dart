import 'package:flutter/material.dart';

class KeyboardKeyContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const KeyboardKeyContainer({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
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
