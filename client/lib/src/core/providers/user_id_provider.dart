import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/settings_storage_provider.dart';
import 'package:parkingson_key/src/core/persistence/settings/settings_storage.dart';

final userIdProvider = NotifierProvider<UserIdNotifier, String>(
  UserIdNotifier.new,
);

class UserIdNotifier extends Notifier<String> {
  static const _defaultUserId = 'default_user';

  late final SettingsStorage _storage = ref.read(settingsStorageProvider);

  @override
  String build() {
    return _storage.getUserId();
  }

  Future<void> setUserId(String userId) async {
    state = userId.isEmpty ? _defaultUserId : userId;
    await _storage.setUserId(state);
  }
}
