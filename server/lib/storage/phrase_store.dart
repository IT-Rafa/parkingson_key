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

  /// Saves a new phrase tree using last-writer-wins semantics.
  ///
  /// Si llegan varios árboles para el mismo userId, el que tenga updatedAt
  /// más reciente reemplaza completamente al anterior.
  PhraseTree save(PhraseTree incoming) {
    final existing = _db.getPhraseTree(incoming.id.split('_')[0]);

    if (existing == null) {
      _db.savePhraseTree(incoming);
      return incoming;
    }

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

  List<PhraseNode> _mergeNodeLists(
    List<PhraseNode> existing,
    List<PhraseNode> incoming,
  ) {
    final Map<String, PhraseNode> existingById = {
      for (final node in existing) node.id: node,
    };

    final Map<String, PhraseNode> incomingById = {
      for (final node in incoming) node.id: node,
    };

    final List<PhraseNode> merged = [];

    for (final node in existing) {
      if (incomingById.containsKey(node.id)) {
        merged.add(_mergeNode(node, incomingById[node.id]!));
      } else {
        merged.add(node);
      }
    }

    for (final node in incoming) {
      if (!existingById.containsKey(node.id)) {
        merged.add(node);
      }
    }

    return merged;
  }

  PhraseNode _mergeNode(PhraseNode existing, PhraseNode incoming) {
    final children = _mergeNodeLists(existing.children, incoming.children);

    return PhraseNode(
      id: existing.id,
      title: incoming.title.isNotEmpty ? incoming.title : existing.title,
      isCategory: existing.isCategory || incoming.isCategory,
      children: children,
      ttsEnabled: incoming.ttsEnabled,
    );
  }
}
