class PhraseNode {
  final String id;
  final String title;        // Texto visible (tema o frase)
  final bool isCategory;     // true = tema, false = frase
  final List<PhraseNode> children;

  const PhraseNode({
    required this.id,
    required this.title,
    required this.isCategory,
    this.children = const [],
  });
}
