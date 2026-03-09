import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/phrase_tree_navigator.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

class PhraseGridPicker extends ConsumerWidget {
  const PhraseGridPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodes = ref.watch(phraseTreeNavigatorProvider);
    final navigator = ref.read(phraseTreeNavigatorProvider.notifier);

    return SafeArea(
      child: Column(
        children: [
          _Header(navigator: navigator),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              itemCount: nodes.length,
              itemBuilder: (context, index) {
                final node = nodes[index];

                return _PhraseButton(
                  node: node,
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
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final PhraseTreeNavigator navigator;

  const _Header({required this.navigator});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: ListTile(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: navigator.goBack,
        ),
        title: Text(
          navigator.currentPath,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _PhraseButton extends StatelessWidget {
  final PhraseNode node;
  final VoidCallback onTap;

  const _PhraseButton({
    required this.node,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCategory = node.isCategory;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isCategory ? Icons.folder : Icons.chat,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            node.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
