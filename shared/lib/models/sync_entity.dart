abstract class SyncEntity {
  final String id;
  final int version;
  final DateTime updatedAt;
  final String updatedByDeviceId;

  const SyncEntity({
    required this.id,
    required this.version,
    required this.updatedAt,
    required this.updatedByDeviceId,
  });
}
