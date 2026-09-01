import 'dart:io';

import 'package:app_datas/app_datas.dart';
import 'package:path/path.dart' as path;
import 'package:sqlite3/sqlite3.dart';

const _createTablesStatements = [
  '''
CREATE TABLE IF NOT EXISTS cache_entries (
  cache_key TEXT PRIMARY KEY,
  input TEXT NOT NULL,
  output TEXT NOT NULL,
  updated_at INTEGER NOT NULL
)
''',
  '''
CREATE TABLE IF NOT EXISTS cache_index (
  cache_key TEXT PRIMARY KEY,
  hash TEXT NOT NULL
)
''',
];

/// Opens the SQLite database backing [CacheIndexRepository], creating its
/// two tables (`cache_entries` for the input/output pair, `cache_index` for
/// the hash used to detect changes) if they do not exist yet.
class LocalCacheDatabase {
  LocalCacheDatabase._(this.database, this.directory);

  final Database database;

  /// The directory this database's files live in, or null for
  /// [LocalCacheDatabase.openInMemory], which is backed by no directory.
  final Directory? directory;

  static Future<LocalCacheDatabase> open(String appId) async {
    final directory = await AppPaths.localCacheDirectory(appId);
    await directory.create(recursive: true);
    final database = sqlite3.open(
      path.join(directory.path, 'local_cache.db'),
    );
    return _withTables(database, directory);
  }

  /// Opens a throwaway in-memory database, for use in tests only.
  factory LocalCacheDatabase.openInMemory() {
    return _withTables(sqlite3.openInMemory(), null);
  }

  static LocalCacheDatabase _withTables(Database database, Directory? directory) {
    for (final statement in _createTablesStatements) {
      database.execute(statement);
    }
    return LocalCacheDatabase._(database, directory);
  }
}
