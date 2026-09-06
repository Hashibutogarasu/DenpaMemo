import 'package:api_client/api_client.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/physique_table/objectbox_evasion_rate_category_cache_repository.dart';
import 'package:denpa_memo/data/physique_table/objectbox_physique_table_cache_repository.dart';
import 'package:denpa_memo/data/physique_table/objectbox_physique_table_metadata_cache_repository.dart';
import 'package:denpa_memo/services/physique_antenna_category_resolver.dart';
import 'package:denpa_memo/services/physique_identification_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'search() reproduces the same match/candidate the real server returns for the same real seed data',
    () async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);

      final tableCacheRepository = PhysiqueTableCacheRepository(objectBox);
      tableCacheRepository.upsertFromServer('evasionRate', [
        const PhysiqueTableRecord(
          type: 'evasionRate',
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 0,
          values: [0, 0, 0, 0, 0, null, null, null, null, null],
        ),
        const PhysiqueTableRecord(
          type: 'evasionRate',
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 1,
          values: [null, 3, 3, 3, 3, 3, 3, null, null, null],
        ),
        const PhysiqueTableRecord(
          type: 'evasionRate',
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 2,
          values: [null, null, null, 6, 6, 6, 6, 6, null, null],
        ),
        const PhysiqueTableRecord(
          type: 'evasionRate',
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 3,
          values: [null, null, null, null, null, 10, 10, null, 10, null],
        ),
        const PhysiqueTableRecord(
          type: 'evasionRate',
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 4,
          values: [null, null, null, null, null, null, null, 15, 15, 15],
        ),
      ]);
      tableCacheRepository.upsertFromServer('hp', [
        const PhysiqueTableRecord(
          type: 'hp',
          level: '1',
          anntenaCategory: 'アンテナ無し',
          lineOffset: 0,
          values: [40, 37, 34, 32, 29, 26, 24, 21, 18, 16],
        ),
      ]);

      final categoryCacheRepository = EvasionRateCategoryCacheRepository(
        objectBox,
      );
      categoryCacheRepository.replaceAll(const [
        PhysiqueEvasionRateCategoryRow(
          id: 'a',
          evasionRateStart: 0,
          evasionRateEnd: 0,
          columnIndex: 0,
          textKey: 'largest',
        ),
        PhysiqueEvasionRateCategoryRow(
          id: 'b',
          evasionRateStart: 0,
          evasionRateEnd: 0,
          columnIndex: 1,
          textKey: 'large',
        ),
        PhysiqueEvasionRateCategoryRow(
          id: 'c',
          evasionRateStart: 0,
          evasionRateEnd: 0,
          columnIndex: 2,
          textKey: 'medium',
        ),
        PhysiqueEvasionRateCategoryRow(
          id: 'd',
          evasionRateStart: 0,
          evasionRateEnd: 0,
          columnIndex: 3,
          textKey: 'fast',
        ),
        PhysiqueEvasionRateCategoryRow(
          id: 'e',
          evasionRateStart: 0,
          evasionRateEnd: 0,
          columnIndex: 4,
          textKey: 'fastest',
        ),
      ]);

      final metadataCacheRepository = PhysiqueTableMetadataCacheRepository(
        objectBox,
      );
      metadataCacheRepository.saveMetadata(
        PhysiqueTableMetadata(
          physiqueAntennaCategories: const [],
          physiqueStatusCategories: const [],
          physiqueAntennaCategoryAntennaLinks: [
            const PhysiqueAntennaCategoryAntennaLink(
              major: 'その他',
              minor: 'アンテナ無し',
              antennaId: 'none',
              antennaName: 'アンテナなし',
            ),
          ],
        ),
      );

      final service = PhysiqueIdentificationService(
        tableCacheRepository: tableCacheRepository,
        categoryCacheRepository: categoryCacheRepository,
        antennaCategoryResolver: PhysiqueAntennaCategoryResolver(
          metadataCacheRepository,
        ),
        awaitInitialSync: () async {},
      );

      final result = await service.search(
        hp: 32,
        evasionRate: 0,
        level: '1',
        antenna: 'none',
      );

      expect(result.matches, hasLength(1));
      final match = result.matches.single;
      expect(match.lineOffset, 0);
      expect(match.columnIndex, 3);
      expect(match.candidates.map((c) => c.textKey), ['fast']);
    },
  );
}
