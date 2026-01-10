import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_accessibility_profile.dart';

class KeyboardProfileNotifier extends Notifier<KeyboardAccessibilityProfile> {
  @override
  KeyboardAccessibilityProfile build() {
    // Perfil por defecto
    return const KeyboardAccessibilityProfile(
      name: 'normal',
      acceptHoldDuration: Duration(milliseconds: 400),
      repeatBlockDuration: Duration(milliseconds: 120),
      hapticEnabled: true,
    );
  }

  void setProfile(KeyboardAccessibilityProfile profile) {
    state = profile;
  }
}

final keyboardProfileProvider =
    NotifierProvider<KeyboardProfileNotifier, KeyboardAccessibilityProfile>(
  KeyboardProfileNotifier.new,
);
