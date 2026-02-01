import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/phrases/phrase_tree/phrase_tree_storage.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';
import 'package:parkingson_key/src/core/phrases/providers/phrase_tree_storage_provider.dart';

class PhraseTreeNotifier extends Notifier<List<PhraseNode>> {
  late final PhraseTreeStorage _storage;

  @override
  List<PhraseNode> build() {
    _storage = ref.read(phraseTreeStorageProvider);
    return _storage.load();
  }

  Future<void> addPhrase(String categoryId, String text) async {
    final newPhrase = PhraseNode(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: text,
      isCategory: false,
    );

    await _storage.addPhrase(
      categoryId: categoryId,
      phrase: newPhrase,
    );

    // Recargar desde Hive
    state = _storage.load();
  }
}
