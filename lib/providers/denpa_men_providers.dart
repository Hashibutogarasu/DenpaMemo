import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/denpa_men/objectbox_denpa_men_repository.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/denpa_men/denpa_men_repository.dart';
import '../domain/master_data/master_data.dart';
import 'objectbox_providers.dart';

final denpaMenRepositoryProvider = Provider<DenpaMenRepository>((ref) {
  return ObjectBoxDenpaMenRepository(ref.watch(objectBoxProvider));
});

/// Streams the saved [DenpaMen] list resolved against [masterData].
final denpaMenListProvider =
    StreamProvider.family<List<DenpaMenRecord>, MasterData>((
      ref,
      masterData,
    ) {
      final repository = ref.watch(denpaMenRepositoryProvider);
      return repository.watchAll(masterData);
    });
