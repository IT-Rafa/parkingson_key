import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:vibration/vibration.dart';

class HapticFeedbackService {
  static Future<void> tap(KeyboardAccessibilityProfile profile) async {
    if (!profile.hapticEnabled) return;

    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator != true) return;

      await Vibration.vibrate(
        duration: 40,
        amplitude: profile.hapticLevel == HapticLevel.strong ? 255 : 80,
      );
    } catch (_) {
      // Desktop / Web / sin motor háptico
    }
  }
}
