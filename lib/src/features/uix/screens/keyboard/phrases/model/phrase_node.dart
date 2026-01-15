class PhraseNode {
  final String id;
  final String title;
  final bool isCategory;
  final List<PhraseNode> children;

  const PhraseNode({
    required this.id,
    required this.title,
    required this.isCategory,
    this.children = const [],
  });

  PhraseNode copyWith({
    String? id,
    String? title,
    bool? isCategory,
    List<PhraseNode>? children,
  }) {
    return PhraseNode(
      id: id ?? this.id,
      title: title ?? this.title,
      isCategory: isCategory ?? this.isCategory,
      children: children ?? this.children,
    );
  }
}
