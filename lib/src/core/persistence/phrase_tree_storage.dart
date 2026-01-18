import 'package:hive/hive.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/model/phrase_node.dart';

class PhraseTreeStorage {
  static const _boxName = 'phrase_tree_box';
  static const _key = 'phrases';

  Box<List>? _box;

  Future<void> init() async {
    _box ??= await Hive.openBox<List>(_boxName);
  }

  List<PhraseNode> load() {
    final data = _box?.get(_key);
    if (data == null) return [];
    return data.cast<PhraseNode>();
  }

  Future<void> save(List<PhraseNode> tree) async {
    await _box?.put(_key, tree);
  }

  Future<void> addPhrase({
    required String categoryId,
    required PhraseNode phrase,
  }) async {
    final tree = load();

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
    await save(tree);
  }
}
