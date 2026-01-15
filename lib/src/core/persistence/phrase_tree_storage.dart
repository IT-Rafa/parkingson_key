import 'package:hive/hive.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/model/phrase_node.dart';

class PhraseTreeStorage {
  static const _boxName = 'phrase_tree_box';
  static const _key = 'phrases';

  late Box<List> _box;

  Future<void> init() async {
    _box = await Hive.openBox<List>(_boxName);
  }

  List<PhraseNode> load() {
    final data = _box.get(_key);
    if (data == null) return [];
    return data.cast<PhraseNode>();
  }

  Future<void> save(List<PhraseNode> tree) async {
    await _box.put(_key, tree);
  }
}
