import 'package:shared/models/phrase_tree.dart';
import 'database_helper.dart';

/// Provides a higher-level API for phrase tree persistence.
class PhraseStore {
  late final DatabaseHelper _db;

  /// Sets the database helper instance used by this store.
  Future<void> init(DatabaseHelper db) async {
    _db = db;
  }

  /// Returns the latest phrase tree for the requested userId.
  PhraseTree? get(String userId) {
    return _db.getPhraseTree(userId);
  }

  /// Saves a new phrase tree or resolves conflicts by keeping the newest version.
  PhraseTree save(PhraseTree incoming) {
    final existing = _db.getPhraseTree(incoming.id.split('_')[0]);

    if (existing == null) {
      _db.savePhraseTree(incoming);
      return incoming;
    }

    // Resolución de conflicto simple:
    // gana el más reciente
    if (incoming.updatedAt.isAfter(existing.updatedAt)) {
      final updated = PhraseTree(
        id: incoming.id,
        version: existing.version + 1,
        updatedAt: DateTime.now().toUtc(),
        updatedByDeviceId: incoming.updatedByDeviceId,
        nodes: incoming.nodes,
      );

      _db.savePhraseTree(updated);
      return updated;
    }

    return existing;
  }
}
