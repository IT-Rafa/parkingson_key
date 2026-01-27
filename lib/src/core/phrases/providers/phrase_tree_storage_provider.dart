import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/phrase_tree_storage.dart';

final phraseTreeStorageProvider = Provider<PhraseTreeStorage>((ref) {
  final storage = PhraseTreeStorage();
  storage.init();
  return storage;
});

