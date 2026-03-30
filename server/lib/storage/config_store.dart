import 'package:shared/models/user_config.dart';
import 'database_helper.dart';

/// Provides a higher-level API for user configuration persistence.
class ConfigStore {
  late final DatabaseHelper _db;

  /// Sets the database helper instance used by this store.
  Future<void> init(DatabaseHelper db) async {
    _db = db;
  }

  /// Returns the latest configuration for the requested userId.
  UserConfig? get(String userId) {
    return _db.getUserConfig(userId);
  }

  /// Saves a new user configuration or resolves conflicts by using the newest update.
  UserConfig save(UserConfig incoming) {
    final existing = _db.getUserConfig(incoming.id.split('_')[0]);

    if (existing == null) {
      _db.saveUserConfig(incoming);
      return incoming;
    }

    // Resolución de conflicto simple:
    // gana el más reciente
    if (incoming.updatedAt.isAfter(existing.updatedAt)) {
      final updated = UserConfig(
        id: incoming.id,
        version: existing.version + 1,
        updatedAt: DateTime.now().toUtc(),
        updatedByDeviceId: incoming.updatedByDeviceId,
        data: incoming.data,
      );

      _db.saveUserConfig(updated);
      return updated;
    }

    return existing;
  }
}
