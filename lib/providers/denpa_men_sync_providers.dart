import 'package:data_cache/data_cache.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import '../data/denpa_men/objectbox_denpa_men_repository.dart';
import 'objectbox_providers.dart';

/// Brings every stored [DenpaMen] record up to date against freshly
/// fetched master data: recomputed hashes ([migrateDenpaMenHashes]) and a
/// refreshed resistance cache entry per record ([CacheIndexRepository]).
class DenpaMenSyncService {
  const DenpaMenSyncService({
    required this.repository,
    required this.cacheIndexRepository,
  });

  final DenpaMenRepository repository;
  final CacheIndexRepository cacheIndexRepository;

  Future<void> sync(MasterData masterData) async {
    migrateDenpaMenHashes(repository, masterData);
    for (final record in repository.getAll(masterData)) {
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
  }
}

final denpaMenSyncServiceProvider = Provider<DenpaMenSyncService>((ref) {
  return DenpaMenSyncService(
    repository: ObjectBoxDenpaMenRepository(ref.watch(objectBoxProvider)),
    cacheIndexRepository: ref.watch(dataCacheProvider),
  );
});

/// Runs [DenpaMenSyncService.sync] against freshly fetched
/// [masterDataProvider] data. The single provider a widget should watch to
/// keep every stored record's hash and resistance cache entry up to date.
/// Never runs while offline, since [masterDataProvider] itself never
/// resolves in that case.
final denpaMenSyncProvider = FutureProvider<void>((ref) async {
  final masterData = await ref.watch(masterDataProvider.future);
  final service = ref.watch(denpaMenSyncServiceProvider);
  await service.sync(masterData);
});
