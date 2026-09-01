import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sqlite3/sqlite3.dart';

import 'cache_entry.dart';
import 'local_cache_database.dart';

enum CacheSyncResult { created, merged, unchanged }

/// Caches input/output pairs behind a hash index, so every mergeability
/// check compares against the same single source (the hash in
/// `cache_index`) instead of reloading and re-comparing the full entry.
/// JSON encoding/decoding is entirely internal: callers pass and receive
/// domain values, never raw `Map<String, dynamic>`.
class CacheIndexRepository {
  CacheIndexRepository._(this._database);

  final Database _database;

  static Future<CacheIndexRepository> open(String appId) async {
    final localCacheDatabase = await LocalCacheDatabase.open(appId);
    return CacheIndexRepository._(localCacheDatabase.database);
  }

  /// Opens a throwaway in-memory repository, for use in tests only.
  factory CacheIndexRepository.createInMemory() {
    return CacheIndexRepository._(LocalCacheDatabase.openInMemory().database);
  }

  /// Reports whether [save] would write a new or changed entry for [key],
  /// based only on comparing hashes.
  Future<bool> canMerge<I, O>(String key, I input, O output) async =>
      canMergeSync(key, input, output);

  /// Synchronous variant of [canMerge], for callers that are themselves
  /// synchronous (e.g. `DenpaMenEntity.toDomain`) and can rely on this
  /// repository's underlying store not doing real asynchronous I/O.
  bool canMergeSync<I, O>(String key, I input, O output) {
    final hash = _hash(input, output);
    final storedHash = _readIndexHash(key);
    return storedHash == null || storedHash != hash;
  }

  /// Writes [input]/[output] for [key] only when [canMerge] would return
  /// true for the same arguments; otherwise leaves the stored entry as-is.
  /// [I]/[O] must be JSON-encodable directly or expose a `toJson()`.
  Future<CacheSyncResult> save<I, O>(String key, I input, O output) async =>
      saveSync(key, input, output);

  /// Synchronous variant of [save].
  CacheSyncResult saveSync<I, O>(String key, I input, O output) {
    final storedHash = _readIndexHash(key);
    final hash = _hash(input, output);
    if (storedHash == hash) {
      return CacheSyncResult.unchanged;
    }
    _writeEntryAndIndex(key, input, output, hash);
    return storedHash == null
        ? CacheSyncResult.created
        : CacheSyncResult.merged;
  }

  /// Reads back the entry stored for [key], decoding it with
  /// [inputFromJson]/[outputFromJson]. Returns null when nothing has been
  /// cached for [key] yet.
  Future<CacheEntry<I, O>?> read<I, O>(
    String key, {
    required I Function(Map<String, dynamic> json) inputFromJson,
    required O Function(Map<String, dynamic> json) outputFromJson,
  }) async => readSync(key, inputFromJson: inputFromJson, outputFromJson: outputFromJson);

  /// Synchronous variant of [read].
  CacheEntry<I, O>? readSync<I, O>(
    String key, {
    required I Function(Map<String, dynamic> json) inputFromJson,
    required O Function(Map<String, dynamic> json) outputFromJson,
  }) {
    final result = _database.select(
      'SELECT input, output FROM cache_entries WHERE cache_key = ?',
      [key],
    );
    if (result.isEmpty) {
      return null;
    }
    final row = result.first;
    return CacheEntry(
      input: inputFromJson(jsonDecode(row['input'] as String) as Map<String, dynamic>),
      output: outputFromJson(jsonDecode(row['output'] as String) as Map<String, dynamic>),
    );
  }

  String? _readIndexHash(String key) {
    final result = _database.select(
      'SELECT hash FROM cache_index WHERE cache_key = ?',
      [key],
    );
    return result.isEmpty ? null : result.first['hash'] as String;
  }

  void _writeEntryAndIndex<I, O>(String key, I input, O output, String hash) {
    final updatedAt = DateTime.now().millisecondsSinceEpoch;
    _database.execute(
      'INSERT INTO cache_entries (cache_key, input, output, updated_at) '
      'VALUES (?, ?, ?, ?) '
      'ON CONFLICT(cache_key) DO UPDATE SET '
      'input = excluded.input, output = excluded.output, '
      'updated_at = excluded.updated_at',
      [key, _encode(input), _encode(output), updatedAt],
    );
    _database.execute(
      'INSERT INTO cache_index (cache_key, hash) VALUES (?, ?) '
      'ON CONFLICT(cache_key) DO UPDATE SET hash = excluded.hash',
      [key, hash],
    );
  }

  String _hash<I, O>(I input, O output) {
    final encoded = jsonEncode(<String, dynamic>{
      'input': input,
      'output': output,
    }, toEncodable: _toEncodable);
    return sha256.convert(utf8.encode(encoded)).toString();
  }

  String _encode<T>(T value) => jsonEncode(value, toEncodable: _toEncodable);

  dynamic _toEncodable(dynamic object) {
    if (object is Map<String, dynamic>) {
      return object;
    }
    return (object as dynamic).toJson();
  }
}
