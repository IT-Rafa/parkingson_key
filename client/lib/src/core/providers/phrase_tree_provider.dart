import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/phrases/phrase_tree_storage.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_storage_provider.dart';
import 'package:parkingson_key/src/core/providers/server_sync_provider.dart';
import 'package:parkingson_key/src/core/providers/settings_storage_provider.dart';
import 'package:parkingson_key/src/core/persistence/settings/settings_storage.dart';
import 'package:parkingson_key/src/core/providers/user_id_provider.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';
import 'package:shared/models/phrase_tree.dart' as shared;

final phraseTreeProvider =
    NotifierProvider<PhraseTreeNotifier, List<PhraseNode>>(
        PhraseTreeNotifier.new);

class PhraseTreeNotifier extends Notifier<List<PhraseNode>> {
  static const _defaultDeviceId = 'default_device';

  late PhraseTreeStorage _storage;
  late final SettingsStorage _settingsStorage;

  @override
  List<PhraseNode> build() {
    _storage = ref.read(phraseTreeStorageProvider);
    _settingsStorage = ref.read(settingsStorageProvider);

    try {
      return _storage.load();
    } catch (_) {
      return [];
    }
  }

  Future<void> reload() async {
    state = _storage.load();
  }

  Future<void> saveTree(List<PhraseNode> tree) async {
    await _storage.save(tree);
    state = tree;
    await _syncTreeToServerSafe();
  }

  Future<void> syncToServer({String? userId}) async {
    final String id = userId ?? ref.read(userIdProvider);
    await _syncConfigToServer(id);
    await _syncTreeToServer(userId: id);
  }

  Future<void> syncFromServer({String? userId}) async {
    final String id = userId ?? ref.read(userIdProvider);
    final serverSyncService = ref.read(serverSyncProvider);
    final remoteTree = await serverSyncService.loadPhraseTree(id);
    if (remoteTree == null) return;

    final localTree = _convertSharedToLocal(remoteTree.nodes);
    await _storage.save(localTree);
    state = localTree;
  }

  Future<void> addPhrase(
    String categoryId,
    PhraseNode newPhrase,
  ) async {
    final tree = _copyTree(state);

    final inserted = _insertIntoCategory(
      tree,
      categoryId,
      newPhrase,
    );

    if (inserted) {
      await _storage.save(tree);
      state = tree;
      await _syncTreeToServerSafe();
    }
  }

  Future<void> _syncTreeToServer({String? userId}) async {
    final String id = userId ?? ref.read(userIdProvider);
    final serverSyncService = ref.read(serverSyncProvider);

    await serverSyncService.savePhraseTree(
      id,
      state,
      _defaultDeviceId,
    );
  }

  Future<void> _syncConfigToServer(String userId) async {
    final configData = {
      'keyboardType': _settingsStorage.getKeyboardType().name,
      'keyboardPreset': _settingsStorage.getKeyboardPreset().name,
      'hapticEnabled': _settingsStorage.getHapticEnabled(),
      'hapticLevel': _settingsStorage.getHapticLevel().name,
      'acceptHoldDurationMs':
          _settingsStorage.getAcceptHoldDuration().inMilliseconds,
    };
    final serverSyncService = ref.read(serverSyncProvider);

    await serverSyncService.saveUserConfig(
      userId,
      configData,
      _defaultDeviceId,
    );
  }

  Future<void> _syncTreeToServerSafe({String? userId}) async {
    try {
      await _syncTreeToServer(userId: userId);
    } catch (_) {
      // ignore errors here to preserve local data when saving
    }
  }

  List<PhraseNode> _convertSharedToLocal(List<shared.PhraseNode> nodes) {
    return nodes
        .map(
          (node) => PhraseNode(
            id: node.id,
            title: node.title,
            isCategory: node.isCategory,
            children: _convertSharedToLocal(node.children),
            ttsEnabled: node.ttsEnabled,
          ),
        )
        .toList();
  }

  bool _insertIntoCategory(
    List<PhraseNode> nodes,
    String categoryId,
    PhraseNode newPhrase,
  ) {
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];

      if (node.id == categoryId && node.isCategory) {
        final updatedChildren = [...node.children, newPhrase];

        nodes[i] = node.copyWith(
          children: updatedChildren,
        );

        return true;
      }

      if (node.children.isNotEmpty) {
        final inserted = _insertIntoCategory(
          node.children,
          categoryId,
          newPhrase,
        );

        if (inserted) {
          nodes[i] = node.copyWith(
            children: node.children,
          );

          return true;
        }
      }
    }

    return false;
  }

  List<PhraseNode> _copyTree(List<PhraseNode> nodes) {
    return nodes
        .map(
          (n) => n.copyWith(
            children: _copyTree(n.children),
          ),
        )
        .toList();
  }
}
