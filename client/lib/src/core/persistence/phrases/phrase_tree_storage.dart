import 'package:hive/hive.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

class PhraseTreeStorage {

  static const boxName = 'phrase_tree_box';
  static const key = 'phrases';

  late final Box<List> _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<List>(boxName);
    } else {
      _box = Hive.box<List>(boxName);
    }
  }

  List<PhraseNode> load() {
    final data = _box.get(key);
    if (data == null) return [];
    return data.cast<PhraseNode>();
  }

  Future<void> save(List<PhraseNode> tree) async {
    await _box.put(key, tree);
  }
}