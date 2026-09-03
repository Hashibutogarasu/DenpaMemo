import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _healSolo1 = Anntena(
  id: 'heal_solo_1',
  category: AnntenaCategory.support,
  targetCount: 1,
  maxLevel: 9,
  evolvesToId: 'heal_solo_2',
  variantGroupId: 'heal',
);

void main() {
  testWidgets(
    'the read-only preview shows the antenna name with its +N suffix',
    (WidgetTester tester) async {
      final headShape = HeadShape(
        id: 'head-a',
        abnormalityResistanceBonuses: const {},
      );
      const physique = Physique(id: 'physique-a');
      const personality = Personality(id: 'personality-a');
      const pattern = Pattern(id: 'pattern-a');
      const colorId = 'color-a';

      final masterData = MasterData(
        headShapes: [headShape],
        anntenas: const [_healSolo1],
        attributes: const [],
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
      );

      final denpaMen = createDenpaMen(
        name: 'test',
        bodyColors: const [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: _healSolo1,
        antennaLevel: 3,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: TestApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: DenpaMenStatus.fromDenpaMen(
                  denpaMen,
                  totalAttributeCount: 1,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('ちょっとかいふく+3'), findsOneWidget);
    },
  );
}
