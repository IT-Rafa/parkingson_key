import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/phrases/phrase_tree_storage.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

final phraseTreeStorageProvider = Provider<PhraseTreeStorage>((ref) {
  return PhraseTreeStorage();
});

final phraseTreeProvider =
    NotifierProvider<PhraseTreeNotifier, List<PhraseNode>>(PhraseTreeNotifier.new);

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

  Future<void> save(List<PhraseNode> tree) async {
    await _storage.save(tree);
    state = tree;
  }

  Future<void> addPhrase(String categoryId, PhraseNode phrase) async {
    final tree = [...state];

    void insert(List<PhraseNode> nodes) {
      for (final n in nodes) {
        if (n.id == categoryId && n.isCategory) {
          n.children.add(phrase);
          return;
        }
        insert(n.children);
      }
    }

    insert(tree);

    await _storage.save(tree);
    state = tree;
  }
}