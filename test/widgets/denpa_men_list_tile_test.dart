import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import 'package:denpa_memo/providers/objectbox_providers.dart';
import 'package:denpa_memo/widgets/denpa_men_list_tile.dart';
import 'package:denpa_memo/widgets/dialog/denpa_men_preview_dialog.dart';
import 'package:graphql_client/graphql_client.dart';

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

  Future<void> pumpTile(
    WidgetTester tester, {
    required DenpaMen denpaMen,
    bool selectionMode = false,
    bool selected = false,
    ValueChanged<bool>? onSelectedChanged,
    VoidCallback? onTap,
    bool enableLongPressPreview = true,
    DenpaMenRecord? record,
    MasterData? recordMasterData,
    ObjectBox? objectBox,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          denpaMenIconProvider.overrideWith((ref, id) async => null),
          masterDataProvider.overrideWithValue(AsyncData(masterData)),
          if (objectBox != null) objectBoxProvider.overrideWithValue(objectBox),
        ],
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: DenpaMenListTile(
                denpaMen: denpaMen,
                selectionMode: selectionMode,
                selected: selected,
                onSelectedChanged: onSelectedChanged,
                onTap: onTap,
                enableLongPressPreview: enableLongPressPreview,
                record: record,
                masterData: recordMasterData,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('selectionMode false: row tap invokes onTap', (tester) async {
    var tapped = false;
    await pumpTile(
      tester,
      denpaMen: buildDenpaMen('individual-a'),
      onTap: () => tapped = true,
    );

    await tester.tap(find.text('individual-a'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets(
    'selectionMode true: row tap invokes onSelectedChanged, not onTap',
    (tester) async {
      var tapped = false;
      bool? changedTo;
      await pumpTile(
        tester,
        denpaMen: buildDenpaMen('individual-a'),
        selectionMode: true,
        onTap: () => tapped = true,
        onSelectedChanged: (value) => changedTo = value,
      );

      await tester.tap(find.text('individual-a'));
      await tester.pump();

      expect(tapped, isFalse);
      expect(changedTo, isTrue);
    },
  );

  testWidgets(
    'enableLongPressPreview false: long-press does not open the preview '
    'dialog',
    (tester) async {
      await pumpTile(
        tester,
        denpaMen: buildDenpaMen('individual-a'),
        enableLongPressPreview: false,
      );

      await tester.longPress(find.text('individual-a'));
      await tester.pumpAndSettle();

      expect(find.byType(DenpaMenPreviewDialog), findsNothing);
    },
  );

  testWidgets('default enableLongPressPreview: long-press opens the preview '
      'dialog', (tester) async {
    await pumpTile(tester, denpaMen: buildDenpaMen('individual-a'));

    await tester.longPress(find.text('individual-a'));
    await tester.pumpAndSettle();

    expect(find.byType(DenpaMenPreviewDialog), findsOneWidget);
  });

  testWidgets(
    'without record/masterData, no trailing action menu is shown',
    (tester) async {
      await pumpTile(tester, denpaMen: buildDenpaMen('individual-a'));

      expect(find.byIcon(Icons.more_vert), findsNothing);
    },
  );

  testWidgets(
    'with record/masterData, the trailing menu deletes the individual after '
    'confirmation',
    (tester) async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final repository = ObjectBoxDenpaMenRepository(objectBox);
      final denpaMen = buildDenpaMen('individual-a');
      final id = repository.save(denpaMen);
      final record = DenpaMenRecord(id: id, denpaMen: denpaMen);

      await pumpTile(
        tester,
        denpaMen: denpaMen,
        record: record,
        recordMasterData: masterData,
        objectBox: objectBox,
      );

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
