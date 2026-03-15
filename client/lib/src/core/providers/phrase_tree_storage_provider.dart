import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/phrases/phrase_tree_storage.dart';

final phraseTreeStorageProvider = Provider<PhraseTreeStorage>((ref) {
  return PhraseTreeStorage();
});
