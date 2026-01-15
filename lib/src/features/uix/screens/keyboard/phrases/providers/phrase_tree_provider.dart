import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/controller/phrase_tree_notifier.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/model/phrase_node.dart';

final phraseTreeProvider =
    NotifierProvider<PhraseTreeNotifier, List<PhraseNode>>(
      PhraseTreeNotifier.new,
    );
