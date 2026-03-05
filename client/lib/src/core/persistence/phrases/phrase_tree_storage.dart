import 'package:hive/hive.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

class PhraseTreeStorage {
  static const _boxName = 'phrase_tree_box';
  static const _key = 'phrases';

  late final Box<List> _box;
  bool _initialized = false;

  /// Inicializa la caja Hive, solo una vez.
  Future<void> init() async {
    if (_initialized) return;

    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<List>(_boxName);
    } else {
      _box = Hive.box<List>(_boxName);
    }

    _initialized = true;
  }

  /// Carga el árbol de frases
  List<PhraseNode> load() {
    final data = _box.get(_key);
    if (data == null) return [];
    return data.cast<PhraseNode>();
  }

  /// Guarda el árbol completo
  Future<void> save(List<PhraseNode> tree) async {
    await _box.put(_key, tree);
  }

  /// Agrega una frase dentro de una categoría
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

  /// Comprueba si hay datos
  bool get isEmpty => _box.isEmpty;
}
