import 'keyboard_accessibility_profile.dart';

class KeyboardAccessibilityProfiles {
  static const light = KeyboardAccessibilityProfile(
    name: 'Leve',
    acceptHoldDuration: Duration(milliseconds: 300),
    repeatBlockDuration: Duration(milliseconds: 200),
    hapticEnabled: true,
  );

  static const medium = KeyboardAccessibilityProfile(
    name: 'Medio',
    acceptHoldDuration: Duration(milliseconds: 500),
    repeatBlockDuration: Duration(milliseconds: 350),
    hapticEnabled: true,
  );

  static const strong = KeyboardAccessibilityProfile(
    name: 'Fuerte',
    acceptHoldDuration: Duration(milliseconds: 800),
    repeatBlockDuration: Duration(milliseconds: 600),
    hapticEnabled: true,
  );
}
