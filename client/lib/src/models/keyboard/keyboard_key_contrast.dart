import 'package:flutter/material.dart';

/// Contraste WCAG 2.1 para texto normal: **AA = 4.5:1** frente al fondo.
///
/// Referencia: https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html
abstract final class KeyboardKeyContrast {
  KeyboardKeyContrast._();

  /// Umbral AA para texto normal (no “large text”).
  static const double minRatioAaNormalText = 4.5;

  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF000000);

  /// Ratio de contraste entre dos colores (1–21).
  static double ratio(Color a, Color b) {
    final l1 = a.computeLuminance();
    final l2 = b.computeLuminance();
    final lighter = l1 > l2 ? l1 : l2;
    final darker = l1 > l2 ? l2 : l1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Elige [foreground] (negro o blanco) y, si hace falta, oscurece o aclara
  /// [desiredBackground] hasta cumplir [minRatioAaNormalText].
  static ({Color background, Color foreground}) aaPair({
    required Color desiredBackground,
    double minRatio = minRatioAaNormalText,
  }) {
    var bg = desiredBackground;
    var fg = ratio(bg, _white) >= ratio(bg, _black) ? _white : _black;
    var r = ratio(bg, fg);

    for (var i = 0; i < 48 && r < minRatio; i++) {
      bg = fg == _white
          ? Color.lerp(bg, _black, 0.12)!
          : Color.lerp(bg, _white, 0.12)!;
      r = ratio(bg, fg);
    }

    if (r < minRatio) {
      // Último recurso: máximo contraste
      return (background: _black, foreground: _white);
    }

    return (background: bg, foreground: fg);
  }

  /// Oscurece el fondo como feedback de pulsación sin bajar de [minRatioAaNormalText]
  /// respecto a [foreground].
  static Color pressedBackgroundAa({
    required Color baseBackground,
    required Color foreground,
    double minRatio = minRatioAaNormalText,
  }) {
    const alphas = <double>[0.22, 0.18, 0.14, 0.10, 0.06, 0.0];
    for (final a in alphas) {
      final pressed = Color.alphaBlend(
        Colors.black.withValues(alpha: a),
        baseBackground,
      );
      if (ratio(pressed, foreground) >= minRatio) return pressed;
    }
    return baseBackground;
  }
}
