import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_provider.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

class PhraseTreeNavigator extends Notifier<List<PhraseNode>> {
  final List<PhraseNode> _stack = [];

  @override
  List<PhraseNode> build() {
    return ref.read(phraseTreeProvider);
  }

  void enterNode(PhraseNode node) {
    if (node.children.isEmpty) return;

    _stack.add(node);

    state = node.children;
  }

  void reset() {
    _stack.clear();
    state = ref.read(phraseTreeProvider);
  }

  bool get isAtRoot => _stack.isEmpty;
  void goBack() {
    if (_stack.isEmpty) return;

    _stack.removeLast();

    state =
        _stack.isEmpty ? ref.read(phraseTreeProvider) : _stack.last.children;
  }

  String get currentPath {
    if (_stack.isEmpty) return 'KEYBOARD_topics'.tr();

    return _stack.map((n) => n.title).join(" > ");
  }
}

final phraseTreeNavigatorProvider =
    NotifierProvider<PhraseTreeNavigator, List<PhraseNode>>(
        PhraseTreeNavigator.new);
