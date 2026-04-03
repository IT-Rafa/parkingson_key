import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/phrase_tree_navigator.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_provider.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';
import 'package:uuid/uuid.dart';

class PhraseTreePicker extends ConsumerWidget {
  final String? phrase;
  final ValueChanged<String>? onPhraseSelected;

  const PhraseTreePicker({
    super.key,
    this.phrase,
    this.onPhraseSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodes = ref.watch(phraseTreeNavigatorProvider);
    final navigator = ref.read(phraseTreeNavigatorProvider.notifier);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: navigator.currentPath == "KEYBOARD_topics".tr()
                ? null
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: navigator.goBack,
                  ),
            title: Text(
              navigator.currentPath,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          ...nodes.map(
            (node) => ListTile(
              title: Text(node.title),
              trailing: node.children.isNotEmpty
                  ? const Icon(Icons.chevron_right)
                  : null,
              onTap: () {
                if (node.children.isNotEmpty) {
                  navigator.enterNode(node);
                  return;
                }

                // nodo hoja
                if (phrase != null) {
                  final newNode = PhraseNode(
                    id: const Uuid().v4(),
                    title: phrase!,
                    isCategory: false,
                    children: [],
                    ttsEnabled: false,
                  );
                  ref
                      .read(phraseTreeProvider.notifier)
                      .addPhrase(node.id, newNode);
                } else {
                  onPhraseSelected?.call(node.title);
                }

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
