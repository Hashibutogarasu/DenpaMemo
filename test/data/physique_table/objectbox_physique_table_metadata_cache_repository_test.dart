import 'dart:convert';

import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/physique_table/objectbox_physique_table_metadata_cache_repository.dart';
import 'package:denpa_memo/data/physique_table/physique_table_metadata_cache_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'cachedMetadata() ignores a cache row saved before antennaId existed instead of throwing',
    () {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);

      objectBox.physiqueTableMetadataCacheBox.put(
        PhysiqueTableMetadataCacheEntity(
          metadataJson: jsonEncode({
            'physiqueAntennaCategories': [],
            'physiqueStatusCategories': [],
            'physiqueAntennaCategoryAntennaLinks': [
              {'major': 'その他', 'minor': 'アンテナ無し', 'antennaName': 'アンテナなし'},
            ],
          }),
        ),
      );

      final repository = PhysiqueTableMetadataCacheRepository(objectBox);

      expect(repository.cachedMetadata(), isNull);
    },
  );
}
