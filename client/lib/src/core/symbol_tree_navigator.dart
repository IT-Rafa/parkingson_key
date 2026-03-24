import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/symbol_tree_provider.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

class SymbolTreeNavigator extends Notifier<List<PhraseNode>> {
  final List<PhraseNode> _stack = [];

  @override
  List<PhraseNode> build() {
    return ref.read(symbolTreeProvider);
  }

  void enterNode(PhraseNode node) {
    if (node.children.isEmpty) return;

    _stack.add(node);
    state = node.children;
  }

  void reset() {
    _stack.clear();
    state = ref.read(symbolTreeProvider);
  }

  bool get isAtRoot => _stack.isEmpty;

  void goBack() {
    if (_stack.isEmpty) return;

    _stack.removeLast();
    state =
        _stack.isEmpty ? ref.read(symbolTreeProvider) : _stack.last.children;
  }

  String get currentPath {
    if (_stack.isEmpty) return 'Symbols';
    return _stack.map((n) => n.title).join(" > ");
  }
}

final symbolTreeNavigatorProvider =
    NotifierProvider<SymbolTreeNavigator, List<PhraseNode>>(
        SymbolTreeNavigator.new);
