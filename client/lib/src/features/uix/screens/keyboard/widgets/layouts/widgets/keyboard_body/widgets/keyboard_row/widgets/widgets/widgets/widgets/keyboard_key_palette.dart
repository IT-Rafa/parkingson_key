import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/themes/app_color.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/widgets/widgets/keyboard_key_contrast.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/widgets/widgets/keyboard_key_visual_category.dart';

/// Par fondo / primer plano con contraste **WCAG AA** (texto normal ≥ 4.5:1).
class KeyboardKeyColors {
  const KeyboardKeyColors({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}

/// Colores de tecla alineados con [AppColors] (marca coral + acento violeta).
/// El ajuste AA puede oscurecer/aclarar el fondo y fijar texto en blanco/negro.
class KeyboardKeyPalette {
  const KeyboardKeyPalette._();

  /// Colores finales para pintar la tecla (cumplen AA frente al fondo de la tecla).
  static KeyboardKeyColors colors(
    BuildContext context,
    KeyboardKeyVisualCategory category,
  ) {
    final desired = _desiredBackground(context, category);
    final pair = KeyboardKeyContrast.aaPair(desiredBackground: desired);
    return KeyboardKeyColors(
      background: pair.background,
      foreground: pair.foreground,
    );
  }

  /// Color “ideal” antes del ajuste AA (útil para documentación / debug).
  static Color desiredBackground(
    BuildContext context,
    KeyboardKeyVisualCategory category,
  ) {
    return _desiredBackground(context, category);
  }

  static Color _c(bool isDark, AppColorPair pair) =>
      isDark ? pair.dark : pair.light;

  static Color _desiredBackground(
    BuildContext context,
    KeyboardKeyVisualCategory category,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (category) {
      case KeyboardKeyVisualCategory.consonant:
        // Tono coral suave (contenedor primario)
        return _c(isDark, AppColors.secondaryContainer);
      case KeyboardKeyVisualCategory.vowel:
        // Tono violeta suave (contenedor secundario)
        return Color.lerp(
            _c(isDark, AppColors.secondaryContainer), Colors.black, 0.15)!;
      case KeyboardKeyVisualCategory.word:
        // Acento violeta para Sí / No / Yes
        return _c(isDark, AppColors.secondary);
      case KeyboardKeyVisualCategory.space:
        return Color.lerp(
            _c(isDark, AppColors.surfaceContainer), Colors.black, 0.25)!;
    }
  }
}
