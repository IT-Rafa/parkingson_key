import 'package:hive/hive.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

class PhraseTreeStorage {

  static const _boxName = 'phrase_tree_box';
  static const _key = 'phrases';

  late final Box<List> _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<List>(_boxName);
    } else {
      _box = Hive.box<List>(_boxName);
    }
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