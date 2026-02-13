import '../models/user_config.dart';

class ConfigStore {
  final Map<String, UserConfig> _store = {};

  UserConfig? get(String userId) => _store[userId];

  UserConfig save(UserConfig incoming) {
    final existing = _store[incoming.userId];

    if (existing == null) {
      _store[incoming.userId] = incoming;
      return incoming;
    }

    // Resolución de conflicto simple:
    // gana el más reciente
    if (incoming.updatedAt.isAfter(existing.updatedAt)) {
      final updated = UserConfig(
        userId: incoming.userId,
        data: incoming.data,
        updatedAt: DateTime.now().toUtc(),
        version: existing.version + 1,
      );

      _store[incoming.userId] = updated;
      return updated;
    }

    return existing;
  }
}
