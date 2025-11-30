import 'package:flutter/material.dart';

double calculateFontSize(String text, double maxHeight, double maxWidth) {
  double fontSize = maxHeight * 0.55;
  final textStyle = TextStyle(fontSize: fontSize);

  final tp = TextPainter(
    text: TextSpan(text: text, style: textStyle),
    textDirection: TextDirection.ltr,
  );

  tp.layout();

  if (tp.width > maxWidth) {
    fontSize = fontSize * (maxWidth / tp.width);
  }

  return fontSize.clamp(10.0, maxHeight * 0.55); // mínimo 10, máximo altura
}
