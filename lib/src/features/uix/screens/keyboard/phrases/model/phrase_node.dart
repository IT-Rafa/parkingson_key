import 'package:hive/hive.dart';

part 'phrase_node.g.dart';

@HiveType(typeId: 1)
class PhraseNode {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isCategory;

  @HiveField(3)
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
