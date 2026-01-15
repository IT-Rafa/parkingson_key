import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/model/phrase_node.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/providers/phrase_tree_provider.dart';


class PhraseBrowser extends ConsumerStatefulWidget {
  const PhraseBrowser({
    super.key,
    required this.onPhraseSelected,
  });

  final ValueChanged<String> onPhraseSelected;

  @override
  ConsumerState<PhraseBrowser> createState() => _PhraseBrowserState();
}

class _PhraseBrowserState extends ConsumerState<PhraseBrowser> {
  final List<PhraseNode> _stack = [];

  List<PhraseNode> get _currentNodes =>
      _stack.isEmpty ? ref.watch(phraseTreeProvider) : _stack.last.children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_stack.isNotEmpty)
          TextButton(
            onPressed: () {
              setState(() {
                _stack.removeLast();
              });
            },
            child: const Text('⬅ Volver'),
          ),
        Expanded(
          child: ListView(
            children: _currentNodes.map((node) {
              return ListTile(
                title: Text(node.title),
                leading: Icon(
                  node.isCategory ? Icons.folder : Icons.message,
                ),
                onTap: () {
                  if (node.isCategory) {
                    setState(() {
                      _stack.add(node);
                    });
                  } else {
                    widget.onPhraseSelected(node.title);
                    Navigator.of(context).pop();
                  }
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
