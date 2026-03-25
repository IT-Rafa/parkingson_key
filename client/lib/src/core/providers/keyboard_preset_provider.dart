import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_preset.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/settings/settings_storage.dart';
import 'package:parkingson_key/src/core/providers/settings_storage_provider.dart';

class KeyboardPresetNotifier extends Notifier<KeyboardAccessibilityPreset> {
  late final SettingsStorage _storage = ref.read(settingsStorageProvider);

  @override
  KeyboardAccessibilityPreset build() {
    return _storage.getKeyboardPreset();
  }

  Future<void> setPreset(KeyboardAccessibilityPreset preset) async {
    state = preset;
    await _storage.setKeyboardPreset(preset);
  }
}

final keyboardPresetProvider =
    NotifierProvider<KeyboardPresetNotifier, KeyboardAccessibilityPreset>(
      KeyboardPresetNotifier.new,
    );
