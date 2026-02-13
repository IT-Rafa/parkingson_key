import 'dart:convert';

class UserConfig {
  final String userId;
  final Map<String, dynamic> data;
  final DateTime updatedAt;
  final int version;

  UserConfig({
    required this.userId,
    required this.data,
    required this.updatedAt,
    required this.version,
  });

  factory UserConfig.fromJson(Map<String, dynamic> json) {
    return UserConfig(
      userId: json['userId'],
      data: Map<String, dynamic>.from(json['data']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'data': data,
        'updatedAt': updatedAt.toIso8601String(),
        'version': version,
      };

  static UserConfig fromRequestBody(String body) {
    return UserConfig.fromJson(jsonDecode(body));
  }
}
