import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/physique_table/objectbox_evasion_rate_category_cache_repository.dart';
import '../data/physique_table/objectbox_physique_table_cache_repository.dart';
import '../data/physique_table/objectbox_physique_table_metadata_cache_repository.dart';
import 'objectbox_providers.dart';

/// The local ObjectBox-backed cache of physique table rows, so offline
/// editing never has to reach `modules/server` directly.
final physiqueTableCacheRepositoryProvider =
    Provider<PhysiqueTableCacheRepository>(
      (ref) => PhysiqueTableCacheRepository(ref.watch(objectBoxProvider)),
    );

/// The local cache of table type/metadata payloads (see
/// [PhysiqueTableMetadataCacheRepository]).
final physiqueTableMetadataCacheRepositoryProvider =
    Provider<PhysiqueTableMetadataCacheRepository>(
      (ref) =>
          PhysiqueTableMetadataCacheRepository(ref.watch(objectBoxProvider)),
    );

/// The local cache of the physique-category legend (see
/// [EvasionRateCategoryCacheRepository]), so identification can resolve
/// evasion-rate ranges to categories offline.
final evasionRateCategoryCacheRepositoryProvider =
    Provider<EvasionRateCategoryCacheRepository>(
      (ref) => EvasionRateCategoryCacheRepository(ref.watch(objectBoxProvider)),
    );
