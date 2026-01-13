import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_preset.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardPresetNotifier extends Notifier<KeyboardAccessibilityPreset> {
  @override
  KeyboardAccessibilityPreset build() {
    return KeyboardAccessibilityPreset.medium; // default
  }

  void setPreset(KeyboardAccessibilityPreset preset) {
    state = preset;
  }
}

final keyboardPresetProvider =
    NotifierProvider<KeyboardPresetNotifier, KeyboardAccessibilityPreset>(
      KeyboardPresetNotifier.new,
    );
