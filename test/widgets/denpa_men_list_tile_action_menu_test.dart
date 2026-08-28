import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import 'package:denpa_memo/providers/objectbox_providers.dart';
import 'package:denpa_memo/widgets/dialog/denpa_men_action_menu.dart';
import 'package:graphql_client/graphql_client.dart';
import '../support/all_translation_providers.dart';

const _anntena = Anntena(id: 'none', category: AnntenaCategory.other);

void main() {
  final headShape = const HeadShape(id: 'head-a');
  const physique = Physique(id: 'physique-a');
  const personality = Personality(id: 'personality-a');
  const pattern = Pattern(id: 'pattern-a');
  const colorId = 'color-a';

  final masterData = MasterData(
    headShapes: [headShape],
    anntenas: const [_anntena],
    attributes: const [Attribute(id: 'fire', index: 0)],
    abnormalityTypes: const [],
    physiques: const [physique],
    personalities: const [personality],
    patterns: const [pattern],
    bodyColorResistanceRules: const [
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: []),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  DenpaMen buildDenpaMen(String name) {
    return createDenpaMen(
      name: name,
      bodyColors: const [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: _anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );
  }

  testWidgets(
    "the trailing menu built from denpaMenActionMenuItems deletes the "
    'individual after confirmation',
    (tester) async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final repository = ObjectBoxDenpaMenRepository(objectBox);
      final denpaMen = buildDenpaMen('individual-a');
      final id = repository.save(denpaMen);
      final record = DenpaMenRecord(id: id, denpaMen: denpaMen);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            denpaMenIconProvider.overrideWith((ref, id) async => null),
            masterDataProvider.overrideWithValue(AsyncData(masterData)),
            objectBoxProvider.overrideWithValue(objectBox),
          ],
          child: AllTranslationProviders(
            child: MaterialApp(
              home: Scaffold(
                body: Consumer(
                  builder: (context, ref, _) => DenpaMenListTile(
                    denpaMen: denpaMen,
                    actionMenuItemsBuilder: (context) =>
                        denpaMenActionMenuItems(
                          context,
                          ref,
                          record: record,
                          masterData: masterData,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.more_vert), findsOneWidget);

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.text('削除'));
      await tester.pumpAndSettle();

      expect(find.text('削除の確認'), findsOneWidget);
      await tester.tap(find.text('削除'));
      await tester.pumpAndSettle();

      expect(repository.getAll(masterData), isEmpty);
    },
  );
}
