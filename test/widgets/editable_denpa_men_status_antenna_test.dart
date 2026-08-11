import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/domain/denpa_men/denpa_men.dart';
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
import 'package:denpa_memo/widgets/editable_denpa_men_status.dart';

const _healSolo1 = Anntena(
  id: 'heal_solo_1',
  category: AnntenaCategory.support,
  targetCount: 1,
  maxLevel: 9,
  evolvesToId: 'heal_solo_2',
  variantGroupId: 'heal',
);
const _healSolo2 = Anntena(
  id: 'heal_solo_2',
  category: AnntenaCategory.support,
  targetCount: 1,
  variantGroupId: 'heal',
);

void main() {
  testWidgets('picking a level via the antenna dialog updates both anntena and '
      'antennaLevel through onChanged', (WidgetTester tester) async {
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
      anntenas: const [_healSolo1, _healSolo2],
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
      anntena: _healSolo1,
      antennaLevel: 3,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );

    DenpaMen? changed;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [denpaMenIconProvider.overrideWith((ref, id) async => null)],
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: EditableDenpaMenStatus(
                  denpaMen: denpaMen,
                  headShapes: masterData.headShapes,
                  anntenas: masterData.anntenas,
                  corrections: masterData.corrections,
                  parentCandidates: const [],
                  qrCodeCandidates: const [],
                  onChanged: (value) => changed = value,
                  considerCorrections: true,
                  onConsiderCorrectionsChanged: (_) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ちょっとかいふく+3'), findsOneWidget);

    await tester.tap(find.text('ちょっとかいふく+3'));
    await tester.pumpAndSettle();

    expect(find.text('ちょっとかいふく+3'), findsWidgets);

    final slider = tester.widgetList<Slider>(find.byType(Slider)).first;
    slider.onChanged!(9);
    await tester.pumpAndSettle();
    expect(find.text('ちょっとかいふく+9'), findsWidgets);

    await tester.tap(find.text('決定'));
    await tester.pumpAndSettle();

    expect(changed, isNotNull);
    expect(changed!.anntena.id, 'heal_solo_1');
    expect(changed!.antennaLevel, 9);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [denpaMenIconProvider.overrideWith((ref, id) async => null)],
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: EditableDenpaMenStatus(
                  denpaMen: changed!,
                  headShapes: masterData.headShapes,
                  anntenas: masterData.anntenas,
                  corrections: masterData.corrections,
                  parentCandidates: const [],
                  qrCodeCandidates: const [],
                  onChanged: (value) => changed = value,
                  considerCorrections: true,
                  onConsiderCorrectionsChanged: (_) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ちょっとかいふく+9'), findsOneWidget);

    await tester.tap(find.text('ちょっとかいふく+9'));
    await tester.pumpAndSettle();

    expect(find.text('ちょっとかいふく+9'), findsWidgets);
    final reopenedSlider = tester.widgetList<Slider>(find.byType(Slider)).first;
    expect(reopenedSlider.value, 9);
  });

  testWidgets('setting the level to +3 and reopening keeps it at 3, not 0', (
    WidgetTester tester,
  ) async {
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
      anntenas: const [_healSolo1, _healSolo2],
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
      anntena: _healSolo1,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );

    DenpaMen? changed;

    Widget buildApp(DenpaMen current) {
      return ProviderScope(
        overrides: [denpaMenIconProvider.overrideWith((ref, id) async => null)],
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: EditableDenpaMenStatus(
                  denpaMen: current,
                  headShapes: masterData.headShapes,
                  anntenas: masterData.anntenas,
                  corrections: masterData.corrections,
                  parentCandidates: const [],
                  qrCodeCandidates: const [],
                  onChanged: (value) => changed = value,
                  considerCorrections: true,
                  onConsiderCorrectionsChanged: (_) {},
                ),
              ),
            ),
          ),
        ),
      );
    }

    await tester.pumpWidget(buildApp(denpaMen));
    await tester.pumpAndSettle();

    expect(find.text('ちょっとかいふく'), findsOneWidget);
    await tester.tap(find.text('ちょっとかいふく'));
    await tester.pumpAndSettle();

    tester.widgetList<Slider>(find.byType(Slider)).first.onChanged!(3);
    await tester.pumpAndSettle();
    expect(find.text('ちょっとかいふく+3'), findsOneWidget);

    await tester.tap(find.text('決定'));
    await tester.pumpAndSettle();

    expect(changed, isNotNull);
    expect(changed!.antennaLevel, 3);

    await tester.pumpWidget(buildApp(changed!));
    await tester.pumpAndSettle();

    expect(find.text('ちょっとかいふく+3'), findsOneWidget);
    await tester.tap(find.text('ちょっとかいふく+3'));
    await tester.pumpAndSettle();

    expect(find.text('ちょっとかいふく+3'), findsWidgets);
    final reopenedSlider = tester.widgetList<Slider>(find.byType(Slider)).first;
    expect(reopenedSlider.value, 3);
  });

  testWidgets('the level slider ranges from 0 to the next evolution tier', (
    WidgetTester tester,
  ) async {
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
      anntenas: const [_healSolo1, _healSolo2],
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
      anntena: _healSolo1,
      antennaLevel: 3,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [denpaMenIconProvider.overrideWith((ref, id) async => null)],
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: EditableDenpaMenStatus(
                  denpaMen: denpaMen,
                  headShapes: masterData.headShapes,
                  anntenas: masterData.anntenas,
                  corrections: masterData.corrections,
                  parentCandidates: const [],
                  qrCodeCandidates: const [],
                  onChanged: (_) {},
                  considerCorrections: true,
                  onConsiderCorrectionsChanged: (_) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('ちょっとかいふく+3'));
    await tester.pumpAndSettle();

    final slider = tester.widgetList<Slider>(find.byType(Slider)).first;
    expect(slider.min, 0);
    expect(slider.max, 18);
  });
}
