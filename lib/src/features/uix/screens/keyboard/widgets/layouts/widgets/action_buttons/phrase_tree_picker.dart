import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/phrases/model/phrase_node.dart';
import 'package:parkingson_key/src/core/phrases/providers/phrase_tree_provider.dart';

class PhraseTreePicker extends ConsumerStatefulWidget {
  final String? phrase; // solo para "Guardar Frase"
  final ValueChanged<String>? onPhraseSelected; // callback para Frases

  const PhraseTreePicker({
    super.key,
    this.phrase,
    this.onPhraseSelected,
  });

  @override
  ConsumerState<PhraseTreePicker> createState() => _PhraseTreePickerState();
}

class _PhraseTreePickerState extends ConsumerState<PhraseTreePicker> {
  List<PhraseNode> currentLevel = [];
  final List<PhraseNode> navigationStack = [];

  @override
  void initState() {
    super.initState();
    currentLevel = ref.read(phraseTreeProvider);
  }

  void enterNode(PhraseNode node) {
    if (node.children.isEmpty) {
      // Hoja final
      if (widget.phrase != null) {
        // Guardar nueva frase
        ref.read(phraseTreeProvider.notifier).addPhrase(node.id, widget.phrase!);
      } else {
        // Seleccionar frase existente
        widget.onPhraseSelected?.call(node.title);
      }
      Navigator.of(context).pop();
    } else {
      // Subtema → navegar
      setState(() {
        navigationStack.add(node);
        currentLevel = node.children;
      });
    }
  }

  void goBack() {
    setState(() {
      navigationStack.removeLast();
      currentLevel = navigationStack.isEmpty
          ? ref.read(phraseTreeProvider)
          : navigationStack.last.children;
    });
  }

  String get currentPath =>
      navigationStack.isEmpty ? 'Temas' : navigationStack.map((n) => n.title).join(' > ');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: navigationStack.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: goBack,
                  ),
            title: Text(currentPath, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),
          ...currentLevel.map(
            (node) => ListTile(
              title: Text(node.title),
              trailing: node.children.isNotEmpty ? const Icon(Icons.chevron_right) : null,
              onTap: () => enterNode(node),
            ),
          ),
        ],
      ),
    );
  }
}
