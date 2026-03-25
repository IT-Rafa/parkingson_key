import 'sync_entity.dart';

class PhraseTree extends SyncEntity {
  final List<PhraseNode> nodes;

  PhraseTree({
    required super.id,
    required super.version,
    required super.updatedAt,
    required super.updatedByDeviceId,
    required this.nodes,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'version': version,
    'updatedAt': updatedAt.toIso8601String(),
    'updatedByDeviceId': updatedByDeviceId,
    'nodes': nodes.map((n) => n.toJson()).toList(),
  };

  factory PhraseTree.fromJson(Map<String, dynamic> json) {
    return PhraseTree(
      id: json['id'],
      version: json['version'],
      updatedAt: DateTime.parse(json['updatedAt']),
      updatedByDeviceId: json['updatedByDeviceId'],
      nodes: (json['nodes'] as List).map((n) => PhraseNode.fromJson(n)).toList(),
    );
  }
}

class PhraseNode {
  final String id;
  final String title;
  final bool isCategory;
  final List<PhraseNode> children;
  final bool ttsEnabled;

  PhraseNode({
    required this.id,
    required this.title,
    this.isCategory = false,
    this.children = const [],
    this.ttsEnabled = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isCategory': isCategory,
    'children': children.map((c) => c.toJson()).toList(),
    'ttsEnabled': ttsEnabled,
  };

  factory PhraseNode.fromJson(Map<String, dynamic> json) {
    return PhraseNode(
      id: json['id'],
      title: json['title'],
      isCategory: json['isCategory'] ?? false,
      children: (json['children'] as List?)?.map((c) => PhraseNode.fromJson(c)).toList() ?? [],
      ttsEnabled: json['ttsEnabled'] ?? false,
    );
  }
}