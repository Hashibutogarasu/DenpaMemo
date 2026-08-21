import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/domain/backup/dm_import_error.dart';
import 'package:denpa_memo/domain/backup/import_result.dart';
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
import 'package:denpa_memo/widgets/dialog/import_complete_dialog.dart';

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

  Future<void> pump(WidgetTester tester, ImportResult result) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [denpaMenIconProvider.overrideWith((ref, id) async => null)],
        child: TranslationProvider(
          child: MaterialApp(home: ImportCompleteDialog(result: result)),
        ),
      ),
    );
  }

  testWidgets('shows every non-empty section with its count', (tester) async {
    await pump(
      tester,
      ImportResult(
        added: [denpaMen],
        merged: [denpaMen],
        orphaned: [denpaMen],
        failed: [
          DenpaMenEntryParseError(index: 0, rawEntry: 'broken'),
        ],
      ),
    );
    await tester.pumpAndSettle();

    final t = Translations();
    expect(find.textContaining(t.backup.importAddedSection), findsOneWidget);
    expect(find.textContaining(t.backup.importMergedSection), findsOneWidget);
    expect(find.textContaining(t.backup.importOrphanedSection), findsOneWidget);
    expect(find.textContaining(t.backup.importFailedSection), findsOneWidget);
  });

  testWidgets('hides sections with no entries', (tester) async {
    await pump(tester, ImportResult(added: [denpaMen]));
    await tester.pumpAndSettle();

    final t = Translations();
    expect(find.textContaining(t.backup.importAddedSection), findsOneWidget);
    expect(find.textContaining(t.backup.importMergedSection), findsNothing);
    expect(find.textContaining(t.backup.importOrphanedSection), findsNothing);
    expect(find.textContaining(t.backup.importFailedSection), findsNothing);
  });
}
