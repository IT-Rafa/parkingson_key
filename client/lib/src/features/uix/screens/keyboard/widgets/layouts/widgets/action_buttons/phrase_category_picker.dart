import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_provider.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

class PhraseCategoryPicker extends ConsumerWidget {
  const PhraseCategoryPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tree = ref.watch(phraseTreeProvider);

    final categories = _collectCategories(tree);

    return SafeArea(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final node = categories[index];

          return ListTile(
            title: Text(node.title),
            onTap: () {
              Navigator.pop(context, node.id);
            },
          );
        },
      ),
    );
  }

  List<PhraseNode> _collectCategories(List<PhraseNode> nodes) {
    final result = <PhraseNode>[];

    void walk(List<PhraseNode> list) {
      for (final node in list) {
        if (node.isCategory) {
          result.add(node);
          walk(node.children);
        }
      }
    }

    walk(nodes);
    return result;
  }
}
