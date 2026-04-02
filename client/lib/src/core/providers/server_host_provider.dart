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

  String _normalizeServerHost(String serverHost) {
    final value = serverHost.trim();
    if (value.isEmpty) return _defaultServerHost;

    final uri = Uri.tryParse(value);
    if (uri == null || uri.scheme.isEmpty) {
      return 'http://$value';
    }

    return value;
  }

  Future<void> setServerHost(String serverHost) async {
    final normalized = _normalizeServerHost(serverHost);
    state = normalized;
    await _storage.setServerHost(normalized);
  }
}
