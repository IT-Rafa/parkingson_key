import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.label, required this.onPressed});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
      final isPortrait =
      MediaQuery.of(context).orientation == Orientation.portrait;

    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      label: SizedBox(
        width: isPortrait ? 55 : 100,
        height: isPortrait ? 50 : 15,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14), 
          ),
        ),
      ),
    );
  }
}
