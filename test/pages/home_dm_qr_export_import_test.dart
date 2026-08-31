import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:graphview/GraphView.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/qr_code/objectbox_qr_code_repository.dart';
import '../support/test_app.dart';

import '../support/fake_path_provider_platform.dart';

void main() {
  testWidgets(
    'exporting a backup entry includes its QR code, and importing it '
    'restores the individual/QR code link and rebuilds the lineage tree',
    (WidgetTester tester) async {
      late Directory tempRoot;
      await tester.runAsync(() async {
        tempRoot = await Directory.systemTemp.createTemp(
          'home_dm_qr_export_import_test',
        );
        PathProviderPlatform.instance = FakePathProviderPlatform(tempRoot.path);
      });
      addTearDown(() async {
        if (await tempRoot.exists()) {
          await tempRoot.delete(recursive: true);
        }
      });

      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      await tester.pumpWidget(TestApp(objectBox: objectBox));
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }

      expect(find.text('qr-linked-individual'), findsNothing);

      final container = ProviderScope.containerOf(
        tester.element(find.byType(MaterialApp)),
      );
      final masterData = container.read(masterDataProvider).value!;

      final qrCode = createQrCode('raw-value-export-with-qr', name: 'group');
      final denpaMen = createDenpaMen(
        name: 'qr-linked-individual',
        bodyColors: [masterData.bodyColorResistanceRules.first.colorId],
        isSpColor: false,
        headShape: masterData.headShapes.first,
        physique: masterData.physiques.first,
        personality: masterData.personalities.first,
        pattern: masterData.patterns.first,
        anntena: masterData.anntenas.first,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      ).copyWith(qrCodeId: qrCode.id);

      final exportedEntries = buildDenpaMenBackupEntries([denpaMen], [qrCode]);
      expect(exportedEntries, hasLength(1));
      expect(
        exportedEntries.single.qrCode,
        isNotNull,
        reason: 'the exported entry must carry the QR code substance, not '
            'just DenpaMen.qrCodeId',
      );
      expect(exportedEntries.single.qrCode!.rawValue, qrCode.rawValue);
      expect(exportedEntries.single.qrCode!.hash, qrCode.hash);

      final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
      final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);
      await tester.runAsync(() async {
        mergeDenpaMenBackupEntries(
          exportedEntries,
          denpaMenRepository: denpaMenRepository,
          qrCodeRepository: qrCodeRepository,
          masterData: masterData,
        );
        await Future<void>.delayed(const Duration(milliseconds: 300));
      });

      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }

      expect(find.text('qr-linked-individual'), findsWidgets);

      final restored = denpaMenRepository.findByCuid(denpaMen.id, masterData);
      expect(restored, isNotNull);
      expect(
        restored!.denpaMen.qrCodeId,
        qrCode.id,
        reason: 'the individual/QR code link must be restored on import',
      );
      final restoredQrCode = qrCodeRepository.findByHash(qrCode.hash);
      expect(restoredQrCode, isNotNull);
      expect(restoredQrCode!.qrCode.rawValue, qrCode.rawValue);

      await tester.tap(find.byIcon(Icons.account_tree));
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }

      expect(tester.takeException(), isNull);
      expect(find.byType(GraphView), findsOneWidget);
    },
  );
}
