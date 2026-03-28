import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/settings_storage_provider.dart';
import 'package:parkingson_key/src/core/persistence/settings/settings_storage.dart';

final serverHostProvider = NotifierProvider<ServerHostNotifier, String>(
  ServerHostNotifier.new,
);

class ServerHostNotifier extends Notifier<String> {
  static const _defaultServerHost = 'http://localhost:8081';

  late final SettingsStorage _storage = ref.read(settingsStorageProvider);

  @override
  String build() {
    return _storage.getServerHost();
  }

  Future<void> setServerHost(String serverHost) async {
    state = serverHost.isEmpty ? _defaultServerHost : serverHost;
    await _storage.setServerHost(state);
  }
}
