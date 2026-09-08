import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import 'package:denpa_memo/theme/app_theme.dart';
import 'package:denpa_memo/widgets/dialog/export_complete_dialog.dart';

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
    attributes: const [],
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

  final denpaMen = createDenpaMen(
    name: 'test-denpa-men',
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

  Future<void> pump(WidgetTester tester, ExportResult result) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [denpaMenIconProvider.overrideWith((ref, id) async => null)],
        child: TranslationProvider(
          child: MaterialApp(
            theme: AppLightTheme.forContrast(AppContrastLevel.standard),
            home: ExportCompleteDialog(result: result),
          ),
        ),
      ),
    );
  }

  testWidgets('shows both sections with their counts', (tester) async {
    await pump(
      tester,
      ExportResult(exported: [denpaMen], orphaned: [denpaMen]),
    );
    await tester.pumpAndSettle();

    final t = Translations();
    expect(find.textContaining(t.backup.exportExportedSection), findsOneWidget);
    expect(find.textContaining(t.backup.exportOrphanedSection), findsOneWidget);
  });

  testWidgets('hides the orphaned section when empty', (tester) async {
    await pump(tester, ExportResult(exported: [denpaMen]));
    await tester.pumpAndSettle();

    final t = Translations();
    expect(find.textContaining(t.backup.exportExportedSection), findsOneWidget);
    expect(find.textContaining(t.backup.exportOrphanedSection), findsNothing);
  });
}
