import 'dart:io';

import 'package:data_cache/data_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_render.dart';
import 'account_scoped_paths_providers.dart'
    show accountScopedAppDirectoryProvider, accountScopedTempDirectoryProvider;

/// Aggregates every on-disk cache source (the offline data cache's SQLite
/// files, the account's temporary/cache directory, and the clipped-icon
/// render cache) behind one API, so callers that need "every cached file"
/// don't have to know how many sources exist or where each one lives.
class CacheFileSources {
  const CacheFileSources(this._ref);

  final Ref _ref;

  /// Every file cached by any source, fetched in a single batch and
  /// unioned into one list.
  Future<List<File>> listAll() async {
    final fileLists = await Future.wait([
      _listOfflineCacheFiles(),
      _listTempCacheFiles(),
      _listClippedImageCacheFiles(),
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

  /// [clippedImageCacheManager] is app-wide rather than account-scoped
  /// (its entries are fully reconstructable from account-scoped source
  /// images either way) and manages its own storage location internally,
  /// so its files are resolved through its own public API — asking its
  /// [CacheInfoRepository] for every entry it knows about, then asking
  /// the manager itself for each entry's actual file — rather than this
  /// app guessing at (and duplicating) where `flutter_cache_manager`
  /// happens to store things on disk.
  Future<List<File>> _listClippedImageCacheFiles() async {
    final repo = clippedImageCacheManager.config.repo;
    await repo.open();
    final objects = await repo.getAllObjects();
    final files = <File>[];
    for (final object in objects) {
      final file = (await clippedImageCacheManager.getFileFromCache(
        object.key,
      ))?.file;
      if (file != null && await file.exists()) {
        files.add(file);
      }
    }
    return files;
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
