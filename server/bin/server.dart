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

/// Entry point for the server application.
/// Initializes the database, stores, HTTP routes, and starts listening on port 8081.
void main() async {
  final db = DatabaseHelper();
  await db.init();

  final configStore = ConfigStore();
  await configStore.init(db);

  final phraseStore = PhraseStore();
  await phraseStore.init(db);
  final router = Router();

  // Health check route returns a simple pong response for diagnostics.
  router.get('/ping', (Request request) {
    return Response.ok('pong');
  });

  // Returns the latest saved user configuration for the given userId.
  router.get('/config/<userId>', (Request request, String userId) {
    final config = configStore.get(userId);

    if (config == null) {
      return Response.notFound('Not found');
    }

    return Response.ok(
      jsonEncode(config.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // Saves or updates the user configuration provided in the request body.
  router.post('/config/<userId>', (Request request, String userId) async {
    final body = await request.readAsString();
    final incoming = UserConfig.fromJson(jsonDecode(body));

    final saved = configStore.save(incoming);

    return Response.ok(
      jsonEncode(saved.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // Returns the saved phrase tree for the requested userId.
  router.get('/phrases/<userId>', (Request request, String userId) {
    final phrases = phraseStore.get(userId);

    if (phrases == null) {
      return Response.notFound('Not found');
    }

    return Response.ok(
      jsonEncode(phrases.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // Saves or updates the phrase tree sent in the request body.
  router.post('/phrases/<userId>', (Request request, String userId) async {
    final body = await request.readAsString();
    final incoming = PhraseTree.fromJson(jsonDecode(body));

    final saved = phraseStore.save(incoming);

    return Response.ok(
      jsonEncode(saved.toJson()),
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
