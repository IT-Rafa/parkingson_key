import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/phrase_tree_storage.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/model/phrase_node.dart';

class PhraseTreeNotifier extends Notifier<List<PhraseNode>> {
  late final PhraseTreeStorage _storage;

  @override
  List<PhraseNode> build() {
    _storage = PhraseTreeStorage();
    return _storage.load();
  }

  Future<void> addPhrase(String categoryId, String text) async {
    state = _addPhraseRecursive(state, categoryId, text);
    await _storage.save(state);
  }

  List<PhraseNode> _addPhraseRecursive(
    List<PhraseNode> nodes,
    String categoryId,
    String text,
  ) {
    return nodes.map((node) {
      if (node.id == categoryId && node.isCategory) {
        return node.copyWith(
          children: [
            ...node.children,
            PhraseNode(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: text,
              isCategory: false,
            ),
          ],
        );
      }

      if (node.children.isNotEmpty) {
        return node.copyWith(
          children: _addPhraseRecursive(node.children, categoryId, text),
        );
      }

      return node;
    }).toList();
  }
}
