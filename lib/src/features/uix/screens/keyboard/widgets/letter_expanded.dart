import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/themes/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LetterExpanded extends StatelessWidget {
  const LetterExpanded({
    super.key,
    required TextEditingController controller,
    required this.letter,
    required this.toWrite,
    this.abreviation,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String letter;
  final String toWrite;
  final String? abreviation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          _controller.text += toWrite;
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.onKey(context),
          backgroundColor: AppColors.key(context),
          padding: const EdgeInsets.all(5),
          minimumSize: Size(40, 40),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 100) {
              // Para pantallas más pequeñas, usa una palabra corta
              return AutoSizeText(
                abreviation ?? letter,
                maxLines: 1,
                minFontSize: 15,
                maxFontSize: 25,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              );
            } else {
              // Para pantallas más anchas, usa una palabra más larga
              return AutoSizeText(
                letter,
                maxLines: 1,
                minFontSize: 18,
                maxFontSize: 30,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              );
            }
          },
        ),
      ),
    );
  }
}
