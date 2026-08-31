import 'dart:io';
import 'dart:typed_data';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/qr_code/objectbox_qr_code_repository.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/providers/denpa_men_icon_providers.dart';
import '../support/test_app.dart';

import '../support/fake_path_provider_platform.dart';

void main() {
  testWidgets(
    'merging a decoded backup entry with an icon restores both the '
    'individual and its icon, updating the home list',
    (WidgetTester tester) async {
      late Directory tempRoot;

      await tester.runAsync(() async {
        tempRoot = await Directory.systemTemp.createTemp(
          'home_dm_icon_import_test',
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

      expect(find.text(t.home.empty), findsOneWidget);

      final container = ProviderScope.containerOf(
        tester.element(find.byType(MaterialApp)),
      );
      final storage = container.read(denpaMenIconStorageProvider);
      final masterData = container.read(masterDataProvider).value!;

      final denpaMen = createDenpaMen(
        name: 'imported-individual',
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
      );
      final iconBytes = Uint8List.fromList(
        img.encodePng(img.Image(width: 4, height: 4)),
      );

      final entry = DenpaMenBackupEntry(denpaMen: denpaMen);
      mergeDenpaMenBackupEntries(
        [entry],
        denpaMenRepository: ObjectBoxDenpaMenRepository(objectBox),
        qrCodeRepository: ObjectBoxQrCodeRepository(objectBox),
        masterData: masterData,
      );

      await tester.runAsync(() async {
        final tempIconFile = File(path.join(tempRoot.path, 'test_import_icon.png'));
        await tempIconFile.writeAsBytes(iconBytes);
        await storage.saveIcon(denpaMen.id, tempIconFile);
        await tempIconFile.delete();
      });

      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }

      expect(find.text(t.home.empty), findsNothing);
      expect(find.text('imported-individual'), findsWidgets);
      expect(objectBox.denpaMenBox.count(), 1);

      File? restoredIconFile;
      await tester.runAsync(() async {
        restoredIconFile = await storage.loadIcon(denpaMen.id);
      });
      expect(restoredIconFile, isNotNull);
      Uint8List? restoredIconBytes;
      await tester.runAsync(() async {
        restoredIconBytes = await restoredIconFile!.readAsBytes();
      });
      expect(restoredIconBytes, iconBytes);
    },
  );
}
