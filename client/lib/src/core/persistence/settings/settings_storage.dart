import 'package:hive_flutter/hive_flutter.dart';
import 'package:parkingson_key/src/core/persistence/hive_service.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_preset.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_type_enum.dart';

class SettingsStorage {
  static const String _boxName = 'settings';
  static const String _keyboardTypeKey = 'keyboardType';
  static const String _keyboardPresetKey = 'keyboardPreset';
  static const String _hapticEnabledKey = 'hapticEnabled';
  static const String _hapticLevelKey = 'hapticLevel';
  static const String _acceptHoldDurationKey = 'acceptHoldDuration';

  late Box<String> _box;

  Future<void> init() async {
    _box = await HiveService.openBox<String>(_boxName);
  }

  KeyboardType getKeyboardType() {
    final value = _box.get(_keyboardTypeKey);
    if (value == null) return KeyboardType.consonantsVowels; // default

    return KeyboardType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => KeyboardType.consonantsVowels,
    );
  }

  Future<void> setKeyboardType(KeyboardType type) async {
    await _box.put(_keyboardTypeKey, type.name);
  }

  KeyboardAccessibilityPreset getKeyboardPreset() {
    final value = _box.get(_keyboardPresetKey);
    if (value == null) return KeyboardAccessibilityPreset.medium; // default

    return KeyboardAccessibilityPreset.values.firstWhere(
      (e) => e.name == value,
      orElse: () => KeyboardAccessibilityPreset.medium,
    );
  }

  Future<void> setKeyboardPreset(KeyboardAccessibilityPreset preset) async {
    await _box.put(_keyboardPresetKey, preset.name);
  }

  bool getHapticEnabled() {
    final value = _box.get(_hapticEnabledKey);
    return value == 'true';
  }

  Future<void> setHapticEnabled(bool enabled) async {
    await _box.put(_hapticEnabledKey, enabled.toString());
  }

  HapticLevel getHapticLevel() {
    final value = _box.get(_hapticLevelKey);
    if (value == null) return HapticLevel.strong; // default

    return HapticLevel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => HapticLevel.strong,
    );
  }

  Future<void> setHapticLevel(HapticLevel level) async {
    await _box.put(_hapticLevelKey, level.name);
  }

  Duration getAcceptHoldDuration() {
    final value = _box.get(_acceptHoldDurationKey);
    if (value == null) return const Duration(milliseconds: 500); // default

    final ms = int.tryParse(value);
    return ms != null ? Duration(milliseconds: ms) : const Duration(milliseconds: 500);
  }

  Future<void> setAcceptHoldDuration(Duration duration) async {
    await _box.put(_acceptHoldDurationKey, duration.inMilliseconds.toString());
  }
}