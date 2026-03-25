import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/settings/settings_storage.dart';
import 'package:parkingson_key/src/core/providers/settings_storage_provider.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_type_enum.dart';

final keyboardTypeProvider =
    NotifierProvider<KeyboardTypeController, KeyboardType>(
  KeyboardTypeController.new,
);

final keyboardLastTypeProvider = StateProvider<KeyboardType?>((_) => null);

class KeyboardTypeController extends Notifier<KeyboardType> {
  late final SettingsStorage _storage = ref.read(settingsStorageProvider);

  @override
  KeyboardType build() {
    return _storage.getKeyboardType();
  }

  Future<void> setType(KeyboardType type) async {
    state = type;
    await _storage.setKeyboardType(type);
  }
}