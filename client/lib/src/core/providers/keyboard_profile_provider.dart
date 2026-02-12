import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/keyboard_accessibility_profiles.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';


class KeyboardProfileNotifier extends Notifier<KeyboardAccessibilityProfile> {
  @override
  KeyboardAccessibilityProfile build() {
    return KeyboardAccessibilityProfiles.medium;
  }

  void setProfile(KeyboardAccessibilityProfile profile) {
    state = profile;
  }

  void setAcceptHold(Duration d) {
    state = state.copyWith(acceptHoldDuration: d);
  }

  void setHapticEnabled(bool v) {
    state = state.copyWith(hapticEnabled: v);
  }

  void setHapticLevel(HapticLevel l) {
    state = state.copyWith(hapticLevel: l);
  }
}

final keyboardProfileProvider = NotifierProvider<
    KeyboardProfileNotifier, KeyboardAccessibilityProfile>(
  KeyboardProfileNotifier.new,
);
