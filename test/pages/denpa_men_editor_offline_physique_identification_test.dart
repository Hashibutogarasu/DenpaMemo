import 'package:api_client/api_client.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/physique_table/objectbox_physique_table_metadata_cache_repository.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/providers/physiques_providers.dart';
import 'package:denpamemo_widgets/i18n/gen/strings.g.dart' as wt;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';

void main() {
  testWidgets(
    'identifying a physique while the server is unreachable does not surface an error, '
    'given the antenna category link is already cached',
    (tester) async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);

      PhysiqueTableMetadataCacheRepository(objectBox).saveMetadata(
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

      await tester.pumpWidget(
        TestApp(
          objectBox: objectBox,
          overrides: [
            physiquesApiClientProvider.overrideWithValue(
              PhysiquesApiClient(Uri.parse('http://127.0.0.1:1')),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.home.addSingle));
      await tester.pumpAndSettle();

      final physiqueTile = find.text(wt.t.editableStatus.physique);
      await tester.ensureVisible(physiqueTile);
      await tester.pumpAndSettle();
      await tester.tap(physiqueTile);
      await tester.pumpAndSettle();

      expect(find.text(t.physiqueIdentification.error), findsNothing);
    },
  );
}
