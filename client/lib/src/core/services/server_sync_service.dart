import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parkingson_key/src/models/phrase/phrase_node.dart' as local;
import 'package:shared/models/phrase_tree.dart' as shared;
import 'package:shared/models/user_config.dart' as shared_config;
import 'package:uuid/uuid.dart';

class ServerSyncService {
  ServerSyncService({String? baseUrl, http.Client? client})
      : _baseUrl = baseUrl ?? _defaultBaseUrl,
        _client = client ?? http.Client();

  final String _baseUrl;
  final http.Client _client;
  final _uuid = const Uuid();

  static String get _defaultBaseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8081';
    }

    return 'http://localhost:8081';
  }

  Uri _buildUri(String path) => Uri.parse('$_baseUrl$path');

  Future<bool> ping() async {
    final response = await _client.get(_buildUri('/ping'));
    return response.statusCode == 200 && response.body.trim() == 'pong';
  }

  Future<shared.PhraseTree?> loadPhraseTree(String userId) async {
    final response = await _client.get(
      _buildUri('/phrases/$userId'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final body = response.body;
      return shared.PhraseTree.fromJson(
          jsonDecode(body) as Map<String, dynamic>);
    }

    return null;
  }

  Future<shared.PhraseTree> savePhraseTree(
    String userId,
    List<local.PhraseNode> nodes,
    String deviceId,
  ) async {
    final tree = _buildPhraseTree(userId, nodes, deviceId);
    final response = await _client.post(
      _buildUri('/phrases/$userId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(tree.toJson()),
    );

    if (response.statusCode != 200) {
      throw HttpException(
          'Failed to save phrase tree: ${response.statusCode} ${response.reasonPhrase ?? ''} ${response.body}',
      );
    }

    final body = response.body;
    try {
      return shared.PhraseTree.fromJson(
          jsonDecode(body) as Map<String, dynamic>);
    } catch (error) {
      throw HttpException('Invalid JSON response for phrases: $body');
    }
  }

  Future<shared_config.UserConfig?> loadUserConfig(String userId) async {
    final response = await _client.get(
      _buildUri('/config/$userId'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final body = response.body;
      return shared_config.UserConfig.fromJson(
          jsonDecode(body) as Map<String, dynamic>);
    }

    return null;
  }

  Future<shared_config.UserConfig> saveUserConfig(
    String userId,
    Map<String, dynamic> data,
    String deviceId,
  ) async {
    final config = shared_config.UserConfig(
      id: '${userId}_${_uuid.v4()}',
      version: 1,
      updatedAt: DateTime.now().toUtc(),
      updatedByDeviceId: deviceId,
      data: data,
    );

    final response = await _client.post(
      _buildUri('/config/$userId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(config.toJson()),
    );

    if (response.statusCode != 200) {
      throw HttpException(
          'Failed to save user config: ${response.statusCode} ${response.reasonPhrase ?? ''} ${response.body}',
      );
    }

    final body = response.body;
    try {
      return shared_config.UserConfig.fromJson(
          jsonDecode(body) as Map<String, dynamic>);
    } catch (error) {
      throw HttpException('Invalid JSON response for config: $body');
    }
  }

  shared.PhraseTree _buildPhraseTree(
    String userId,
    List<local.PhraseNode> nodes,
    String deviceId,
  ) {
    final now = DateTime.now().toUtc();
    return shared.PhraseTree(
      id: '${userId}_${now.millisecondsSinceEpoch}',
      version: 1,
      updatedAt: now,
      updatedByDeviceId: deviceId,
      nodes: nodes.map(_mapNode).toList(),
    );
  }

  shared.PhraseNode _mapNode(local.PhraseNode node) {
    return shared.PhraseNode(
      id: node.id,
      title: node.title,
      isCategory: node.isCategory,
      children: node.children.map(_mapNode).toList(),
      ttsEnabled: node.ttsEnabled,
    );
  }
}
