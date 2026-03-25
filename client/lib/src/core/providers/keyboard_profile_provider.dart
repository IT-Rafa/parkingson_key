import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:parkingson_key/src/core/persistence/settings/settings_storage.dart';
import 'package:parkingson_key/src/core/providers/settings_storage_provider.dart';


class KeyboardProfileNotifier extends Notifier<KeyboardAccessibilityProfile> {
  late final SettingsStorage _storage = ref.read(settingsStorageProvider);

  @override
  KeyboardAccessibilityProfile build() {
    return KeyboardAccessibilityProfile(
      name: 'Custom', // or load if stored
      acceptHoldDuration: _storage.getAcceptHoldDuration(),
      repeatBlockDuration: const Duration(milliseconds: 350), // default from medium
      hapticEnabled: _storage.getHapticEnabled(),
      hapticLevel: _storage.getHapticLevel(),
    );
  }

  Future<void> setProfile(KeyboardAccessibilityProfile profile) async {
    state = profile;
    await _storage.setAcceptHoldDuration(profile.acceptHoldDuration);
    await _storage.setHapticEnabled(profile.hapticEnabled);
    await _storage.setHapticLevel(profile.hapticLevel);
  }

  Future<void> setAcceptHold(Duration d) async {
    state = state.copyWith(acceptHoldDuration: d);
    await _storage.setAcceptHoldDuration(d);
  }

  Future<void> setHapticEnabled(bool v) async {
    state = state.copyWith(hapticEnabled: v);
    await _storage.setHapticEnabled(v);
  }

  Future<void> setHapticLevel(HapticLevel l) async {
    state = state.copyWith(hapticLevel: l);
    await _storage.setHapticLevel(l);
  }
}

final keyboardProfileProvider = NotifierProvider<
    KeyboardProfileNotifier, KeyboardAccessibilityProfile>(
  KeyboardProfileNotifier.new,
);
