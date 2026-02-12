class SyncRequest {
  final String deviceId;
  final int currentVersion;

  SyncRequest({
    required this.deviceId,
    required this.currentVersion,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'currentVersion': currentVersion,
      };
}