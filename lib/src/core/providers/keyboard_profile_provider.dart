import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_accessibility_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class KeyboardProfileNotifier extends Notifier<KeyboardAccessibilityProfile> {
  static const _hapticKey = 'haptic_level';

  @override
  KeyboardAccessibilityProfile build() {
    _load(); // carga SharedPreferences
    return const KeyboardAccessibilityProfile(
      name: 'default',     
      acceptHoldDuration: Duration(milliseconds: 400),
      repeatBlockDuration: Duration(milliseconds: 120),
      hapticEnabled: true,
      hapticLevel: HapticLevel.strong,
    );
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_hapticKey);

    if (value != null) {
      state = state.copyWith(
        hapticLevel: value == 'soft' ? HapticLevel.soft : HapticLevel.strong,
      );
    }
  }

  Future<void> setHapticLevel(HapticLevel level) async {
    state = state.copyWith(hapticLevel: level);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_hapticKey, level.name);
  }

  void setHapticEnabled(bool enabled) {
    state = state.copyWith(hapticEnabled: enabled);
  }

  void setAcceptHold(Duration duration) {
    state = state.copyWith(acceptHoldDuration: duration);
  }

  void setRepeatBlock(Duration duration) {
    state = state.copyWith(repeatBlockDuration: duration);
  }
}

final keyboardProfileProvider = NotifierProvider<
    KeyboardProfileNotifier, KeyboardAccessibilityProfile>(
  KeyboardProfileNotifier.new,
);
