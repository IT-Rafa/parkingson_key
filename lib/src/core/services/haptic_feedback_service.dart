import 'package:flutter/services.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_accessibility_profile.dart';

class HapticFeedbackService {
  static void tap(KeyboardAccessibilityProfile profile) {
    if (!profile.hapticEnabled) return;

    switch (profile.hapticLevel) {
      case HapticLevel.soft:
        HapticFeedback.lightImpact();
        break;
      case HapticLevel.strong:
        HapticFeedback.heavyImpact();
        break;
    }
  }
}
