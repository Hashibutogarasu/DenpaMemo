import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/physique_table/objectbox_physique_table_cache_repository.dart';
import 'objectbox_providers.dart';

/// The local ObjectBox-backed cache of physique table rows, so offline
/// editing never has to reach `modules/server` directly.
final physiqueTableCacheRepositoryProvider =
    Provider<PhysiqueTableCacheRepository>(
      (ref) => PhysiqueTableCacheRepository(ref.watch(objectBoxProvider)),
    );
