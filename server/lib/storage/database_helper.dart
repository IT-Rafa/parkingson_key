import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:shared/models/user_config.dart';
import 'package:shared/models/phrase_tree.dart';

/// Wraps the SQLite database and exposes persistence operations.
class DatabaseHelper {
  late final Database _db;

  /// Opens or creates the local SQLite database and initializes tables.
  Future<void> init() async {
    final dbPath = p.join(Directory.current.path, 'server.db');
    _db = sqlite3.open(dbPath);

    _createTables();
  }

  /// Creates the database tables that store user configs and phrase trees.
  void _createTables() {
    // User configs table
    _db.execute('''
      CREATE TABLE IF NOT EXISTS user_configs (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        data TEXT NOT NULL,
        version INTEGER NOT NULL,
        updated_at TEXT NOT NULL,
        updated_by_device_id TEXT NOT NULL
      )
    ''');

    // Phrases table
    _db.execute('''
      CREATE TABLE IF NOT EXISTS phrases (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        tree_data TEXT NOT NULL,
        version INTEGER NOT NULL,
        updated_at TEXT NOT NULL,
        updated_by_device_id TEXT NOT NULL
      )
    ''');
  }

  // UserConfig operations
  /// Retrieves the latest saved UserConfig for the given userId.
  UserConfig? getUserConfig(String userId) {
    final result = _db.select(
      'SELECT * FROM user_configs WHERE user_id = ? ORDER BY version DESC LIMIT 1',
      [userId],
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return UserConfig.fromJson({
      'id': row['id'],
      'version': row['version'],
      'updatedAt': row['updated_at'],
      'updatedByDeviceId': row['updated_by_device_id'],
      'data': jsonDecode(row['data'] as String),
    });
  }

  /// Persists or updates a UserConfig record in the database.
  void saveUserConfig(UserConfig config) {
    _db.execute(
      'INSERT OR REPLACE INTO user_configs (id, user_id, data, version, updated_at, updated_by_device_id) VALUES (?, ?, ?, ?, ?, ?)',
      [
        config.id,
        config.id.split('_')[0], // Assuming id is userId_version or similar
        jsonEncode(config.data),
        config.version,
        config.updatedAt.toIso8601String(),
        config.updatedByDeviceId,
      ],
    );
  }

  // Phrases operations
  /// Retrieves the latest saved PhraseTree for the given userId.
  PhraseTree? getPhraseTree(String userId) {
    final result = _db.select(
      'SELECT * FROM phrases WHERE user_id = ? ORDER BY version DESC LIMIT 1',
      [userId],
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return PhraseTree.fromJson({
      'id': row['id'],
      'version': row['version'],
      'updatedAt': row['updated_at'],
      'updatedByDeviceId': row['updated_by_device_id'],
      'nodes': jsonDecode(row['tree_data'] as String),
    });
  }

  /// Persists or updates a PhraseTree record in the database.
  void savePhraseTree(PhraseTree tree) {
    _db.execute(
      'INSERT OR REPLACE INTO phrases (id, user_id, tree_data, version, updated_at, updated_by_device_id) VALUES (?, ?, ?, ?, ?, ?)',
      [
        tree.id,
        tree.id.split('_')[0], // Assuming id is userId_version
        jsonEncode(tree.nodes.map((n) => n.toJson()).toList()),
        tree.version,
        tree.updatedAt.toIso8601String(),
        tree.updatedByDeviceId,
      ],
    );
  }

  /// Closes the database connection and releases resources.
  void close() {
    _db.dispose();
  }
}
