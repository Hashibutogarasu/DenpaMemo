import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'denpa_men_providers.dart';

/// Filters applied to [filteredDenpaMenProvider]; reset by [SearchResults]
/// on dispose so the home screen stops showing stale results.
final searchQueryProvider = StateProvider<DenpaMenSearchQuery>(
  (ref) => const DenpaMenSearchQuery(),
);

/// The search page's draft, independent of [searchQueryProvider] so it
/// survives leaving [SearchResults]; copied into [searchQueryProvider] only
/// when the user opens results.
final searchFormDraftProvider = StateProvider<DenpaMenSearchQuery>(
  (ref) => const DenpaMenSearchQuery(),
);

final _allDenpaMenProvider = Provider.family<List<DenpaMenRecord>, MasterData>(
  (ref, masterData) =>
      ref.watch(denpaMenListProvider(masterData)).value ?? [],
);

final _nameFilteredDenpaMenProvider =
    Provider.family<List<DenpaMenRecord>, MasterData>((ref, masterData) {
      final name = ref.watch(searchQueryProvider.select((q) => q.name));
      final records = ref.watch(_allDenpaMenProvider(masterData));
      if (name.isEmpty) return records;
      return [for (final r in records) if (r.denpaMen.name.contains(name)) r];
    });

final _headShapeFilteredDenpaMenProvider =
    Provider.family<List<DenpaMenRecord>, MasterData>((ref, masterData) {
      final headShapeId = ref.watch(
        searchQueryProvider.select((q) => q.headShapeId),
      );
      final records = ref.watch(_nameFilteredDenpaMenProvider(masterData));
      if (headShapeId == null) return records;
      return [
        for (final r in records)
          if (r.denpaMen.headShape.id == headShapeId) r,
      ];
    });

final _antennaFilteredDenpaMenProvider =
    Provider.family<List<DenpaMenRecord>, MasterData>((ref, masterData) {
      final antennaId = ref.watch(
        searchQueryProvider.select((q) => q.antennaId),
      );
      final minAntennaLevel = ref.watch(
        searchQueryProvider.select((q) => q.minAntennaLevel),
      );
      var records = ref.watch(_headShapeFilteredDenpaMenProvider(masterData));
      if (antennaId != null) {
        records = [
          for (final r in records)
            if (r.denpaMen.anntena.id == antennaId) r,
        ];
      }
      if (minAntennaLevel != null) {
        records = [
          for (final r in records)
            if (r.denpaMen.antennaLevel >= minAntennaLevel) r,
        ];
      }
      return records;
    });

final _bodyColorFilteredDenpaMenProvider =
    Provider.family<List<DenpaMenRecord>, MasterData>((ref, masterData) {
      final bodyColors = ref.watch(
        searchQueryProvider.select((q) => q.bodyColors),
      );
      final isSpColor = ref.watch(
        searchQueryProvider.select((q) => q.isSpColor),
      );
      var records = ref.watch(_antennaFilteredDenpaMenProvider(masterData));
      if (bodyColors.isNotEmpty) {
        records = [
          for (final r in records)
            if (bodyColors.every(r.denpaMen.bodyColors.contains)) r,
        ];
      }
      if (isSpColor != null) {
        records = [
          for (final r in records)
            if (r.denpaMen.isSpColor == isSpColor) r,
        ];
      }
      return records;
    });

final _memoFilteredDenpaMenProvider =
    Provider.family<List<DenpaMenRecord>, MasterData>((ref, masterData) {
      final memo = ref.watch(searchQueryProvider.select((q) => q.memo));
      final records = ref.watch(_bodyColorFilteredDenpaMenProvider(masterData));
      if (memo.isEmpty) return records;
      return [
        for (final r in records)
          if ((r.denpaMen.memo ?? '').contains(memo)) r,
      ];
    });

final _statFilteredDenpaMenProvider =
    Provider.family<List<DenpaMenRecord>, MasterData>((ref, masterData) {
      final query = ref.watch(searchQueryProvider);
      final records = ref.watch(_memoFilteredDenpaMenProvider(masterData));
      return [
        for (final r in records)
          if ((query.minHp == null || r.denpaMen.hp >= query.minHp!) &&
              (query.minAp == null || r.denpaMen.ap >= query.minAp!) &&
              (query.minAttack == null ||
                  r.denpaMen.attack >= query.minAttack!) &&
              (query.minDefense == null ||
                  r.denpaMen.defense >= query.minDefense!) &&
              (query.minSpeed == null || r.denpaMen.speed >= query.minSpeed!) &&
              (query.minEvasionRate == null ||
                  r.denpaMen.evasionRate >= query.minEvasionRate!))
            r,
      ];
    });

/// Final stage of the filter pipeline: applies every [searchQueryProvider]
/// condition to [denpaMenListProvider] in sequence. UI code should watch
/// only this provider, never the intermediate stages above.
final filteredDenpaMenProvider =
    Provider.family<List<DenpaMenRecord>, MasterData>(
      (ref, masterData) =>
          ref.watch(_statFilteredDenpaMenProvider(masterData)),
    );
