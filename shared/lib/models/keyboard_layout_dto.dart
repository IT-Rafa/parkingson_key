import 'package:shared/models/sync_entity.dart';

class KeyboardLayoutDto extends SyncEntity {
  final String name;
  final List<List<String>> portrait;
  final List<List<String>> landscape;

  KeyboardLayoutDto({
    required super.id,
    required super.version,
    required super.updatedAt,
    required super.updatedByDeviceId,
    required this.name,
    required this.portrait,
    required this.landscape,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'version': version,
    'updatedAt': updatedAt.toIso8601String(),
    'updatedByDeviceId': updatedByDeviceId,
    'name': name,
    'portrait': portrait,
    'landscape': landscape,
  };

  factory KeyboardLayoutDto.fromJson(Map<String, dynamic> json) {
    return KeyboardLayoutDto(
      id: json['id'],
      version: json['version'],
      updatedAt: DateTime.parse(json['updatedAt']),
      updatedByDeviceId: json['updatedByDeviceId'],
      name: json['name'],
      portrait: List<List<String>>.from(
        json['portrait'].map((row) => List<String>.from(row)),
      ),
      landscape: List<List<String>>.from(
        json['landscape'].map((row) => List<String>.from(row)),
      ),
    );
  }
}
