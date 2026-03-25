import 'dart:convert';
import 'dart:io';
import 'package:server/storage/config_store.dart';
import 'package:server/storage/database_helper.dart';
import 'package:server/storage/phrase_store.dart';
import 'package:shared/models/user_config.dart';
import 'package:shared/models/phrase_tree.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';


void main() async {
  final db = DatabaseHelper();
  await db.init();

  final configStore = ConfigStore();
  await configStore.init(db);

  final phraseStore = PhraseStore();
  await phraseStore.init(db);
  final router = Router();

  // Health check
  router.get('/ping', (Request request) {
    return Response.ok('pong');
  });

  // Obtener configuración
  router.get('/config/<userId>', (Request request, String userId) {
    final config = configStore.get(userId);

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
    final incoming = UserConfig.fromJson(jsonDecode(body));

    final saved = configStore.save(incoming);

    return Response.ok(
      saved.toJson().toString(),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // Obtener frases
  router.get('/phrases/<userId>', (Request request, String userId) {
    final phrases = phraseStore.get(userId);

    if (phrases == null) {
      return Response.notFound('Not found');
    }

    return Response.ok(
      phrases.toJson().toString(),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // Guardar frases
  router.post('/phrases/<userId>', (Request request, String userId) async {
    final body = await request.readAsString();
    final incoming = PhraseTree.fromJson(jsonDecode(body));

    final saved = phraseStore.save(incoming);

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
    8081,
  );

  print('Server running on http://${server.address.host}:${server.port}');
}
