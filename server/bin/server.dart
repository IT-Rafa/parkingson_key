import 'dart:io';
import 'package:server/models/user_config.dart';
import 'package:server/storage/config_store.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';


void main() async {
  final store = ConfigStore();
  final router = Router();

  // Health check
  router.get('/ping', (Request request) {
    return Response.ok('pong');
  });

  // Obtener configuración
  router.get('/config/<userId>', (Request request, String userId) {
    final config = store.get(userId);

    if (config == null) {
      return Response.notFound('Not found');
    }

    return Response.ok(
      config.toJson().toString(),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // Guardar configuración
  router.post('/config/<userId>', (Request request, String userId) async {
    final body = await request.readAsString();
    final incoming = UserConfig.fromRequestBody(body);

    final saved = store.save(incoming);

    return Response.ok(
      saved.toJson().toString(),
      headers: {'Content-Type': 'application/json'},
    );
  });

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final server = await serve(
    handler,
    InternetAddress.anyIPv4,
    8080,
  );

  print('Server running on http://${server.address.host}:${server.port}');
}
