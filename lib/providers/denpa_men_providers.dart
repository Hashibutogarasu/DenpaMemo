import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/denpa_men/objectbox_denpa_men_repository.dart';
import '../domain/denpa_men/denpa_men.dart';
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

/// Whether the home accordion list is in multi-select mode. Turned on
/// either from the AppBar overflow menu or by long-pressing a tile, and
/// turned off once the selection is cleared or an action is taken.
final selectionModeProvider = StateProvider<bool>((ref) => false);

/// Ids of the [DenpaMenRecord]s currently selected on the home screen.
final selectedDenpaMenIdsProvider = StateProvider<Set<int>>((ref) => {});

/// [DenpaMen] entries most recently copied or cut from the home screen,
/// held in memory for a future paste feature.
final denpaMenClipboardProvider = StateProvider<List<DenpaMen>>((ref) => []);

/// Ids of records that were cut and are pending a paste-driven removal.
/// Rendered as greyed-out until consumed or the selection is cleared.
final cutDenpaMenIdsProvider = StateProvider<Set<int>>((ref) => {});

/// Whether the Ctrl+F search overlay is currently shown.
final searchOverlayOpenProvider = StateProvider<bool>((ref) => false);
