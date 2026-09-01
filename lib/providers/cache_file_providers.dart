import 'dart:io';

import 'package:data_cache/data_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'account_scoped_paths_providers.dart'
    show accountScopedAppDirectoryProvider, accountScopedTempDirectoryProvider;

/// Aggregates every on-disk cache source (the offline data cache's SQLite
/// files, and the account's temporary/cache directory) behind one API, so
/// callers that need "every cached file" don't have to know how many
/// sources exist or where each one lives.
class CacheFileSources {
  const CacheFileSources(this._ref);

  final Ref _ref;

  /// Every file cached by any source, fetched in a single batch and
  /// unioned into one list.
  Future<List<File>> listAll() async {
    final fileLists = await Future.wait([
      _listOfflineCacheFiles(),
      _listTempCacheFiles(),
    ]);
    return fileLists.expand((files) => files).toList();
  }

  Future<List<File>> _listOfflineCacheFiles() =>
      _ref.read(dataCacheProvider).listCachedFiles();

  Future<List<File>> _listTempCacheFiles() async {
    final tempDirectory = await _ref.read(
      accountScopedTempDirectoryProvider.future,
    );
    return listFilesRecursively(tempDirectory);
  }
}

final cacheFileSourcesProvider = Provider<CacheFileSources>(
  (ref) => CacheFileSources(ref),
);

/// Total size, in bytes, of every cached file across all sources.
final cachedDataSizeProvider = FutureProvider<int>((ref) async {
  final files = await ref.watch(cacheFileSourcesProvider).listAll();
  return totalFileSize(files);
});

/// Total size, in bytes, of the account's persistent application folder
/// (icons and anything else stored there).
final applicationFolderSizeProvider = FutureProvider<int>((ref) async {
  final appDirectory = await ref.watch(
    accountScopedAppDirectoryProvider.future,
  );
  final files = await listFilesRecursively(appDirectory);
  return totalFileSize(files);
});

/// Lists every regular file under [directory], recursively. Returns an
/// empty list when [directory] does not exist.
Future<List<File>> listFilesRecursively(Directory directory) async {
  if (!await directory.exists()) {
    return const [];
  }
  return directory
      .list(recursive: true)
      .where((entity) => entity is File)
      .cast<File>()
      .toList();
}

/// Sums the on-disk size of every file in [files].
Future<int> totalFileSize(List<File> files) async {
  final sizes = await Future.wait(files.map((file) => file.length()));
  return sizes.fold<int>(0, (total, size) => total + size);
}
