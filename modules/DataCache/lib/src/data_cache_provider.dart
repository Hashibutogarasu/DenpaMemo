import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cache_index_repository.dart';

/// Overridden with the [CacheIndexRepository] instance opened in `main`
/// before `runApp`, so every provider that depends on it can assume it is
/// ready.
final dataCacheProvider = Provider<CacheIndexRepository>((ref) {
  throw UnimplementedError('dataCacheProvider must be overridden in main()');
});
