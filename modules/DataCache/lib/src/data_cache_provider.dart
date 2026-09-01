import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart' show StateProvider;

import 'cache_index_repository.dart';

/// Overridden with the [CacheIndexRepository] instance opened in `main`
/// before `runApp`, so every provider that depends on it can assume it is
/// ready.
final dataCacheProvider = Provider<CacheIndexRepository>((ref) {
  throw UnimplementedError('dataCacheProvider must be overridden in main()');
});

/// Bumped whenever [dataCacheProvider] is cleared. Providers reading
/// through the cache should `ref.watch` this to invalidate themselves on
/// a clear, decoupling the clearing code from those providers.
final cacheGenerationProvider = StateProvider<int>((ref) => 0);
