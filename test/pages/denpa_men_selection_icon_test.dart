import 'dart:io';
import 'dart:typed_data';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:image/image.dart' as img;

import 'package:denpa_memo/pages/denpa_men_selection.dart';
import 'package:denpa_memo/providers/account_scoped_paths_providers.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import 'package:denpa_memo/providers/denpa_men_providers.dart';
import 'package:denpa_memo/theme/app_theme.dart';

import '../support/all_translation_providers.dart';

const _masterData = MasterData(
  headShapes: [HeadShape(id: 'head')],
  anntenas: [Anntena(id: 'antenna', category: AnntenaCategory.other)],
  attributes: [],
  abnormalityTypes: [],
  bodyColorResistanceRules: [
    BodyColorResistanceRule(colorId: 'color', attributeResistanceBonuses: []),
  ],
  bodyColorAbnormalityResistanceRules: [],
  physiques: [Physique(id: 'physique')],
  personalities: [Personality(id: 'personality')],
  patterns: [Pattern(id: 'pattern')],
  corrections: [],
);

void main() {
  testWidgets(
    'a candidate with a saved icon shows it in the parent-selection list, '
    'not a placeholder',
    (tester) async {
      late Directory tempRoot;

      await tester.runAsync(() async {
        tempRoot = await Directory.systemTemp.createTemp(
          'denpa_men_selection_icon_test',
        );
      });
      addTearDown(() async {
        if (await tempRoot.exists()) {
          await tempRoot.delete(recursive: true);
        }
      });

      final denpaMen = createDenpaMen(
        name: 'candidate',
        bodyColors: [_masterData.bodyColorResistanceRules.first.colorId],
        isSpColor: false,
        headShape: _masterData.headShapes.first,
        physique: _masterData.physiques.first,
        personality: _masterData.personalities.first,
        pattern: _masterData.patterns.first,
        anntena: _masterData.anntenas.first,
        masterData: _masterData,
        maxHappiness: 0,
        maxLevel: 1,
      );
      final record = DenpaMenRecord(id: 1, denpaMen: denpaMen);

      Widget buildApp(Widget home) => ProviderScope(
        overrides: [
          masterDataProvider.overrideWithValue(const AsyncData(_masterData)),
          denpaMenListProvider.overrideWith(
            (ref, masterData) => Stream.value([record]),
          ),
          accountScopedAppDirectoryProvider.overrideWith(
            (ref) async => tempRoot,
          ),
        ],
        child: AllTranslationProviders(
          child: MaterialApp(
            theme: AppLightTheme.forContrast(AppContrastLevel.standard),
            home: home,
          ),
        ),
      );

      await tester.pumpWidget(
        buildApp(
          const DenpaMenSelectionPage(
            args: DenpaMenSelectionArgs(
              excludeId: 'excluded',
              initialSelectedIds: [],
              maxSelectable: 1,
            ),
          ),
        ),
      );

      final container = ProviderScope.containerOf(
        tester.element(find.byType(DenpaMenSelectionPage)),
      );
      await tester.runAsync(() async {
        final storage = container.read(denpaMenIconStorageProvider);
        final iconFile = File('${tempRoot.path}/candidate_icon.png');
        await iconFile.writeAsBytes(
          Uint8List.fromList(img.encodePng(img.Image(width: 4, height: 4))),
        );
        await storage.saveIcon(denpaMen.id, iconFile, slot: 'icon');
      });
      await tester.runAsync(
        () => container.read(denpaMenIconProvider(denpaMen.id).future),
      );
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }

      final imageFinder = find.byWidgetPredicate((widget) {
        if (widget is! Image) return false;
        final provider = widget.image;
        final fileImage = provider is ResizeImage
            ? provider.imageProvider
            : provider;
        return fileImage is FileImage &&
            fileImage.file.path.contains(denpaMen.id);
      });
      expect(imageFinder, findsOneWidget);
      expect(find.byIcon(Icons.image_outlined), findsNothing);

      await tester.pumpWidget(buildApp(const SizedBox()));
      await tester.pumpAndSettle();
    },
  );
}
