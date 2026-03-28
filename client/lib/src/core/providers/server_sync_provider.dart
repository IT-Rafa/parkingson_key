import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/server_host_provider.dart';
import 'package:parkingson_key/src/core/services/server_sync_service.dart';

final serverSyncProvider = Provider<ServerSyncService>((ref) {
  final serverHost = ref.watch(serverHostProvider);
  return ServerSyncService(baseUrl: serverHost);
});
