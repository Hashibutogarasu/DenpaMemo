import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _anntena = Anntena(id: 'none', category: AnntenaCategory.other);

void main() {
  testWidgets(
    'the preview dialog shows a resolved icon, reusing the same preview '
    'container the edit screen uses',
    (WidgetTester tester) async {
      final headShape = HeadShape(
        id: 'head-a',
        abnormalityResistanceBonuses: const {},
      );
      const physique = Physique(id: 'physique-a');
      const personality = Personality(id: 'personality-a');
      const pattern = Pattern(id: 'pattern-a');
      const colorId = 'color-a';

      final denpaMen = createDenpaMen(
        name: 'test',
        bodyColors: const [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: _anntena,
        masterData: MasterData(
          headShapes: [headShape],
          anntenas: const [_anntena],
          attributes: const [Attribute(id: 'fire', index: 0)],
          abnormalityTypes: const [],
          physiques: const [physique],
          personalities: const [personality],
          patterns: const [pattern],
          bodyColorResistanceRules: const [
            BodyColorResistanceRule(
              colorId: colorId,
              attributeResistanceBonuses: [],
            ),
          ],
          bodyColorAbnormalityResistanceRules: const [],
          corrections: const [],
        ),
        maxHappiness: 0,
        maxLevel: 1,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: TestApp(
            home: DenpaMenPreviewDialog(
              denpaMen: denpaMen,
              totalAttributeCount: 1,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ResolvedEntityIcon), findsOneWidget);
    },
  );

  testWidgets(
    'the preview dialog does not add an extra frame around the shared '
    'preview container',
    (WidgetTester tester) async {
      final headShape = HeadShape(
        id: 'head-a',
        abnormalityResistanceBonuses: const {},
      );
      const physique = Physique(id: 'physique-a');
      const personality = Personality(id: 'personality-a');
      const pattern = Pattern(id: 'pattern-a');
      const colorId = 'color-a';

      final denpaMen = createDenpaMen(
        name: 'test',
        bodyColors: const [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: _anntena,
        masterData: MasterData(
          headShapes: [headShape],
          anntenas: const [_anntena],
          attributes: const [Attribute(id: 'fire', index: 0)],
          abnormalityTypes: const [],
          physiques: const [physique],
          personalities: const [personality],
          patterns: const [pattern],
          bodyColorResistanceRules: const [
            BodyColorResistanceRule(
              colorId: colorId,
              attributeResistanceBonuses: [],
            ),
          ],
          bodyColorAbnormalityResistanceRules: const [],
          corrections: const [],
        ),
        maxHappiness: 0,
        maxLevel: 1,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: TestApp(
            home: DenpaMenPreviewDialog(
              denpaMen: denpaMen,
              totalAttributeCount: 1,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(scrollView.padding, isNull);
    },
  );
}
