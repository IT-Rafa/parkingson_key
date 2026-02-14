import 'sync_entity.dart';

class UserConfig extends SyncEntity {
  final Map<String, dynamic> data;

  UserConfig({
    required super.id,
    required super.version,
    required super.updatedAt,
    required super.updatedByDeviceId,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'version': version,
    'updatedAt': updatedAt.toIso8601String(),
    'updatedByDeviceId': updatedByDeviceId,
    'data': data,
  };

  factory UserConfig.fromJson(Map<String, dynamic> json) {
    return UserConfig(
      id: json['id'],
      version: json['version'],
      updatedAt: DateTime.parse(json['updatedAt']),
      updatedByDeviceId: json['updatedByDeviceId'],
      data: Map<String, dynamic>.from(json['data']),
    );
  }
}
