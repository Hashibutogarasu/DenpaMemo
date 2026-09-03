import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations, TranslationProvider;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/theme/app_theme.dart';

import '../support/all_translation_providers.dart';

const _anntena = Anntena(id: 'none', category: AnntenaCategory.other);

void main() {
  Future<void> pumpEditableQrCode(
    WidgetTester tester, {
    required bool enabled,
    required String qrCodeId,
    required List<QrCodeRecord> candidates,
  }) async {
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
      anntena: _anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
      qrCodeId: qrCodeId,
    );

    await tester.pumpWidget(
      AllTranslationProviders(
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: EditableQrCode(
              denpaMen: denpaMen,
              candidates: candidates,
              enabled: enabled,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('disabled: tapping the QR code field does not open the selection '
      'dialog, and the already-linked QR code still shows by name', (
    WidgetTester tester,
  ) async {
    final qrCode = createQrCode('raw-value', id: 'qr-1', name: 'group-a');

    await pumpEditableQrCode(
      tester,
      enabled: false,
      qrCodeId: 'qr-1',
      candidates: [QrCodeRecord(id: 1, qrCode: qrCode)],
    );

    expect(find.text('group-a'), findsOneWidget);

    await tester.tap(find.text('group-a'));
    await tester.pumpAndSettle();

    expect(find.text('決定'), findsNothing);
  });

  testWidgets('enabled: tapping the QR code field opens the selection dialog', (
    WidgetTester tester,
  ) async {
    final qrCode = createQrCode('raw-value', id: 'qr-1', name: 'group-a');

    await pumpEditableQrCode(
      tester,
      enabled: true,
      qrCodeId: 'qr-1',
      candidates: [QrCodeRecord(id: 1, qrCode: qrCode)],
    );

    await tester.tap(find.text('group-a'));
    await tester.pumpAndSettle();

    expect(find.text('決定'), findsOneWidget);
  });
}
