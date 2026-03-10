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

    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            _Header(navigator: navigator),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9, // más alto para frases largas
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
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final PhraseTreeNavigator navigator;

  const _Header({required this.navigator});

  @override
  Widget build(BuildContext context) {
    // Mejor: añadimos un getter público en PhraseTreeNavigator
    final isRoot = navigator.isAtRoot;

    return SafeArea(
      bottom: false,
      child: Material(
        elevation: 2,
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (isRoot) {
                Navigator.pop(context); // cierra el picker
              } else {
                navigator.goBack();
              }
            },
          ),
          title: Text(
            navigator.currentPath,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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
              node.title,
              textAlign: TextAlign.center,
              softWrap: true, // permite varias líneas
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
