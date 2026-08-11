import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/body_color_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import 'package:denpa_memo/widgets/dialog/denpa_men_preview_dialog.dart';
import 'package:denpa_memo/widgets/icon/denpa_men_icon.dart';

const _anntena = Anntena(id: 'none', category: AnntenaCategory.other);

void main() {
  testWidgets(
    'the preview dialog shows the individual\'s icon, reusing the same '
    'preview container the edit screen uses',
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
        anntenas: const [_anntena],
        attributes: const [],
        abnormalityTypes: const [],
        physiques: const [physique],
        personalities: const [personality],
        patterns: const [pattern],
        bodyColorResistanceRules: const [
          BodyColorResistanceRule(
            colorId: colorId,
            attributeResistanceBonuses: {},
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
        anntena: _anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            denpaMenIconProvider.overrideWith((ref, id) async => null),
          ],
          child: TranslationProvider(
            child: MaterialApp(
              home: DenpaMenPreviewDialog(
                denpaMen: denpaMen,
                totalAttributeCount: 1,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DenpaMenIcon), findsOneWidget);
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

      final masterData = MasterData(
        headShapes: [headShape],
        anntenas: const [_anntena],
        attributes: const [],
        abnormalityTypes: const [],
        physiques: const [physique],
        personalities: const [personality],
        patterns: const [pattern],
        bodyColorResistanceRules: const [
          BodyColorResistanceRule(
            colorId: colorId,
            attributeResistanceBonuses: {},
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
        anntena: _anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            denpaMenIconProvider.overrideWith((ref, id) async => null),
          ],
          child: TranslationProvider(
            child: MaterialApp(
              home: DenpaMenPreviewDialog(
                denpaMen: denpaMen,
                totalAttributeCount: 1,
              ),
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
