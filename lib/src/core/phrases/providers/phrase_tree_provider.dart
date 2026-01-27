import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/phrases/controller/phrase_tree_notifier.dart';
import 'package:parkingson_key/src/core/phrases/model/phrase_node.dart';

final phraseTreeProvider =
    NotifierProvider<PhraseTreeNotifier, List<PhraseNode>>(
  PhraseTreeNotifier.new,
);

