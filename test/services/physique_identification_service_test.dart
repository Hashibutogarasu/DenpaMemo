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
    'search() resolves an antenna id to its cached anntenaCategory and finds the matching column',
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
          id: 'largest',
          evasionRateStart: 0,
          evasionRateEnd: 0,
          columnIndex: 3,
          textKey: 'largest',
        ),
      ]);

      final metadataCacheRepository = PhysiqueTableMetadataCacheRepository(
        objectBox,
      );
      metadataCacheRepository.saveMetadata(
        const PhysiqueTableMetadata(
          physiqueAntennaCategories: [],
          physiqueStatusCategories: [],
          physiqueAntennaCategoryAntennaLinks: [
            PhysiqueAntennaCategoryAntennaLink(
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

      expect(result.matches, [
        isA<PhysiqueColumnMatch>()
            .having((match) => match.level, 'level', '1')
            .having(
              (match) => match.anntenaCategory,
              'anntenaCategory',
              'アンテナ無し',
            )
            .having((match) => match.columnIndex, 'columnIndex', 3),
      ]);
    },
  );
}
