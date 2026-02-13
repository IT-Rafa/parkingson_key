import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_preset.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';

class KeyboardAccessibilityProfiles {
  static const light = KeyboardAccessibilityProfile(
    name: 'Leve',
    acceptHoldDuration: Duration(milliseconds: 300),
    repeatBlockDuration: Duration(milliseconds: 200),
    hapticEnabled: true,
    hapticLevel: HapticLevel.soft,
  );

  static const medium = KeyboardAccessibilityProfile(
    name: 'Medio',
    acceptHoldDuration: Duration(milliseconds: 500),
    repeatBlockDuration: Duration(milliseconds: 350),
    hapticEnabled: true,
    hapticLevel: HapticLevel.strong,
  );

  static const strong = KeyboardAccessibilityProfile(
    name: 'Fuerte',
    acceptHoldDuration: Duration(milliseconds: 800),
    repeatBlockDuration: Duration(milliseconds: 600),
    hapticEnabled: true,
    hapticLevel: HapticLevel.strong,
  );

  static const Map<KeyboardAccessibilityPreset, KeyboardAccessibilityProfile>
  presets = {
    KeyboardAccessibilityPreset.light: light,
    KeyboardAccessibilityPreset.medium: medium,
    KeyboardAccessibilityPreset.strong: strong,
  };
}
