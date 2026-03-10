import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/phrase_tree_navigator.dart';

class PhrasePicker extends ConsumerWidget {
  const PhrasePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodes = ref.watch(phraseTreeNavigatorProvider);
    final navigator = ref.read(phraseTreeNavigatorProvider.notifier);

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.arrow_back),
          title: Text(navigator.currentPath),
          onTap: navigator.goBack,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: nodes.length,
            itemBuilder: (context, index) {
              final node = nodes[index];

              return ElevatedButton(
                onPressed: () {
                  if (node.isCategory) {
                    navigator.enterNode(node);
                  } else {
                    Navigator.pop(context, node.title);
                  }
                },
                child: Text(node.title),
              );
            },
          ),
        ),
      ],
    );
  }
}
