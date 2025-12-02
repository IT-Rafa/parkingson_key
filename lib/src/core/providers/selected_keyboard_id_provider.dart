import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/shared_prefs_provider.dart';

class SelectedKeyboardNotifier extends Notifier<String?> {
  @override
  String? build() {
    final prefs = ref.read(sharedPrefsProvider);
    return prefs.getString('selectedKeyboard');
  }

  Future<void> setKeyboard(String id) async {
    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setString('selectedKeyboard', id);
    state = id;
  }
}

final selectedKeyboardIdProvider =
    NotifierProvider<SelectedKeyboardNotifier, String?>(() {
  return SelectedKeyboardNotifier();
});
