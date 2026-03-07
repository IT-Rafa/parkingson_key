import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/phrases/phrase_tree_storage.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

final phraseTreeStorageProvider = Provider<PhraseTreeStorage>((ref) {
  throw UnimplementedError();
});

class PhraseTreeNotifier extends Notifier<List<PhraseNode>> {
  late PhraseTreeStorage _storage;

  @override
  List<PhraseNode> build() {
    _storage = ref.read(phraseTreeStorageProvider);
    return _storage.load();
  }

  Future<void> reload() async {
    state = _storage.load();
  }

  Future<void> saveTree(List<PhraseNode> tree) async {
    await _storage.save(tree);
    state = tree;
  }

  Future<void> addPhrase(String categoryId, PhraseNode newPhrase) async {
    final tree = _copyTree(state);

    bool inserted = _insertIntoCategory(tree, categoryId, newPhrase);

    if (inserted) {
      await _storage.save(tree);
      state = tree;
    }
  }

  bool _insertIntoCategory(
    List<PhraseNode> nodes,
    String categoryId,
    PhraseNode newPhrase,
  ) {
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];

      if (node.id == categoryId && node.isCategory) {
        final updatedChildren = [...node.children, newPhrase];

        nodes[i] = node.copyWith(children: updatedChildren);
        return true;
      }

      if (node.children.isNotEmpty) {
        final inserted = _insertIntoCategory(
          node.children,
          categoryId,
          newPhrase,
        );

        if (inserted) {
          nodes[i] = node.copyWith(children: node.children);
          return true;
        }
      }
    }

    return false;
  }

  List<PhraseNode> _copyTree(List<PhraseNode> nodes) {
    return nodes
        .map(
          (n) => n.copyWith(
            children: _copyTree(n.children),
          ),
        )
        .toList();
  }
}