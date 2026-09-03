import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/denpa_men/objectbox_denpa_men_repository.dart';
import 'objectbox_providers.dart';

/// Brings every stored [DenpaMen] record up to date against freshly
/// fetched master data: recomputed hashes ([migrateDenpaMenHashes]) and a
/// refreshed resistance cache entry per record ([CacheIndexRepository]).
class DenpaMenSyncService {
  const DenpaMenSyncService({
    required this.repository,
    required this.cacheIndexRepository,
    this.recordsPerSyncBatch = 20,
  });

  final DenpaMenRepository repository;
  final CacheIndexRepository cacheIndexRepository;
  final int recordsPerSyncBatch;

  Future<void> sync(MasterData masterData) async {
    var offset = 0;
    while (true) {
      final batch = repository.getRange(
        masterData,
        offset: offset,
        limit: recordsPerSyncBatch,
      );
      if (batch.isEmpty) return;
      await migrateDenpaMenHashes(repository, batch);
      for (final record in batch) {
        final denpaMen = record.denpaMen;
        await cacheIndexRepository.save(
          denpaMen.id,
          DenpaMenResistanceCacheInput.fromDenpaMen(denpaMen),
          DenpaMenResistanceCacheOutput((
            abnormalityResistances: denpaMen.abnormalityResistances,
            attributeResistance: denpaMen.attributeResistance,
          )),
        );
      }
      await Future(() {});
      if (batch.length < recordsPerSyncBatch) return;
      offset += recordsPerSyncBatch;
    }
  }
}

final denpaMenSyncServiceProvider = Provider<DenpaMenSyncService>((ref) {
  return DenpaMenSyncService(
    repository: ObjectBoxDenpaMenRepository(ref.watch(objectBoxProvider)),
    cacheIndexRepository: ref.watch(dataCacheProvider),
  );
});
