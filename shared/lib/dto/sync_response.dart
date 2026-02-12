import 'package:shared/models/user_config.dart';

class SyncResponse {
  final bool hasChanges;
  final UserConfig? config;

  SyncResponse({
    required this.hasChanges,
    this.config,
  });

  Map<String, dynamic> toJson() => {
        'hasChanges': hasChanges,
        'config': config?.toJson(),
      };
}