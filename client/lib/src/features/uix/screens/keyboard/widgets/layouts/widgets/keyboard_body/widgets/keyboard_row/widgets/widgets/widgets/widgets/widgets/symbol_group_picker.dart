import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/symbol_tree_navigator.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

String _symbolNodeTitle(BuildContext context, PhraseNode node) {
  if (!node.isCategory) return node.title;

  switch (node.id) {
    case 'sym_punctuation':
      return tr('SYMBOLS_punctuation');
    case 'sym_intonation':
      return tr('SYMBOLS_intonation');
    case 'sym_grouping':
      return tr('SYMBOLS_grouping');
    case 'sym_math':
      return tr('SYMBOLS_math');
    case 'sym_social':
      return tr('SYMBOLS_social');
    case 'sym_money':
      return tr('SYMBOLS_money');
    case 'sym_other':
      return tr('SYMBOLS_other');
    default:
      return node.title;
  }
}

String _symbolPathTitle(BuildContext context, SymbolTreeNavigator navigator) {
  final stack = navigator.currentPathNodes;
  if (stack.isEmpty) return tr('KEYBOARD_symbols');
  return stack.map((node) => _symbolNodeTitle(context, node)).join(' > ');
}

class SymbolGroupPicker extends ConsumerWidget {
  const SymbolGroupPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbolNodes = ref.watch(symbolTreeNavigatorProvider);
    final navigator = ref.read(symbolTreeNavigatorProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_symbolPathTitle(context, navigator)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (navigator.isAtRoot) {
                Navigator.pop(context);
              } else {
                navigator.goBack();
              }
            },
          ),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemCount: symbolNodes.length,
          itemBuilder: (context, index) {
            final node = symbolNodes[index];
            final title = _symbolNodeTitle(context, node);

            return _SymbolButton(
              node: node,
              title: title,
              onTap: () {
                if (node.isCategory) {
                  navigator.enterNode(node);
                } else {
                  Navigator.pop(context, node.title);
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _SymbolButton extends StatelessWidget {
  final PhraseNode node;
  final String title;
  final VoidCallback onTap;

  const _SymbolButton({
    required this.node,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (node.isCategory) ...[
            const Icon(Icons.folder, size: 28),
            const SizedBox(height: 6),
          ],
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: node.isCategory ? 14 : 24,
                fontWeight: node.isCategory ? FontWeight.normal : FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
