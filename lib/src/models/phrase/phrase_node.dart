import 'package:hive/hive.dart';

part 'phrase_node.g.dart';

@HiveType(typeId: 1)
class PhraseNode extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isCategory;

  @HiveField(3)
  final List<PhraseNode> children;

  @HiveField(4)
  final bool ttsEnabled;

  PhraseNode({
    required this.id,
    required this.title,
    this.isCategory = false,
    this.children = const [],
    this.ttsEnabled = false,
  });

  PhraseNode copyWith({
    String? id,
    String? title,
    bool? isCategory,
    List<PhraseNode>? children,
    bool? ttsEnabled,
  }) {
    return PhraseNode(
      id: id ?? this.id,
      title: title ?? this.title,
      isCategory: isCategory ?? this.isCategory,
      children: children ?? this.children,
      ttsEnabled: ttsEnabled ?? this.ttsEnabled,
    );
  }
}
