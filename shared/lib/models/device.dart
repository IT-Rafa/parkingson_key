class Device {
  final String id;
  final String userId;
  final String name;
  final DateTime lastSyncAt;

  Device({
    required this.id,
    required this.userId,
    required this.name,
    required this.lastSyncAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'lastSyncAt': lastSyncAt.toIso8601String(),
      };

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      lastSyncAt: DateTime.parse(json['lastSyncAt']),
    );
  }
}
