import 'dart:convert';
import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:dm_file/src/export/dm_export_steps.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

// This test exercises `CopyIconsStep` without ever importing
// `DenpaMenImageSlotType` from `package:data_pack`, using plain string
// slot keys instead — matching CopyIconsStep's own slot-agnostic design
// (see `DmExportContext.loadIcons`), which is exactly what this test is
// meant to demonstrate.

const _headShape = HeadShape(id: 'head');
const _physique = Physique(id: 'physique');
const _personality = Personality(id: 'personality');
const _pattern = Pattern(id: 'pattern');
const _anntena = Anntena(id: 'antenna', category: AnntenaCategory.other);

DenpaMen _denpaMen(String id) {
  return DenpaMen(
    id: id,
    name: id,
    abnormalityResistances: const [],
    bodyColors: const [],
    attributeResistance: const [],
    physique: _physique,
    personality: _personality,
    pattern: _pattern,
    headShape: _headShape,
    anntena: _anntena,
    isSpColor: false,
    happiness: 0,
    maxHappiness: 0,
    level: 1,
    maxLevel: 1,
    currentExp: null,
    maxExp: null,
    hp: 0,
    ap: 0,
    attack: 0,
    defense: 0,
    speed: 0,
    evasionRate: 0,
    corrections: const [],
    considerCorrections: false,
    parentIds: const [],
  );
}

void main() {
  late Directory tempRoot;
  late Directory workDirectory;

  setUp(() async {
    tempRoot = await Directory.systemTemp.createTemp('copy_icons_step_test');
    workDirectory = Directory(path.join(tempRoot.path, 'work'));
    await workDirectory.create(recursive: true);
  });

  tearDown(() async {
    if (await tempRoot.exists()) {
      await tempRoot.delete(recursive: true);
    }
  });

  Future<File> writeDummyPng(String name) async {
    final file = File(path.join(tempRoot.path, name));
    await file.writeAsBytes([0, 1, 2, 3]);
    return file;
  }

  DmExportContext buildContext({
    required List<DenpaMenBackupEntry> entries,
    required Future<Map<String, File>> Function(String denpaMenId) loadIcons,
  }) {
    final context = DmExportContext(
      candidates: [for (final entry in entries) entry.denpaMen],
      masterData: MasterData(
        headShapes: const [_headShape],
        anntenas: const [_anntena],
        attributes: const [],
        abnormalityTypes: const [],
        physiques: const [_physique],
        personalities: const [_personality],
        patterns: const [_pattern],
        bodyColorResistanceRules: const [],
        bodyColorAbnormalityResistanceRules: const [],
        corrections: const [],
      ),
      qrCodes: const [],
      loadIcons: loadIcons,
      dataVersion: '1.0.0',
      onProgress: (_) {},
    );
    context.workDirectory = workDirectory;
    context.entries = entries;
    return context;
  }

  Future<Map<String, dynamic>> readMetadata(String slotDirectoryPath) async {
    final metadataFile = File(path.join(slotDirectoryPath, 'metadata.json'));
    return jsonDecode(await metadataFile.readAsString())
        as Map<String, dynamic>;
  }

  test(
    'copies every slot returned by loadIcons under its own slot-key directory',
    () async {
      final iconFile = await writeDummyPng('icon.png');
      final faceFile = await writeDummyPng('face.png');
      final entry = DenpaMenBackupEntry(denpaMen: _denpaMen('individual-1'));

      final context = buildContext(
        entries: [entry],
        loadIcons: (denpaMenId) async => {'icon': iconFile, 'face': faceFile},
      );

      await CopyIconsStep().run(context);

      final iconSlotDir = path.join(
        workDirectory.path,
        'icons',
        'denpamens',
        'individual-1',
        'icon',
      );
      final faceSlotDir = path.join(
        workDirectory.path,
        'icons',
        'denpamens',
        'individual-1',
        'face',
      );
      expect(await File(path.join(iconSlotDir, 'icon.png')).exists(), isTrue);
      expect((await readMetadata(iconSlotDir))['fileName'], 'icon.png');
      expect(await File(path.join(faceSlotDir, 'icon.png')).exists(), isTrue);
      expect((await readMetadata(faceSlotDir))['fileName'], 'icon.png');
    },
  );

  test(
    'does not create a directory for a slot loadIcons did not return',
    () async {
      final iconFile = await writeDummyPng('icon.png');
      final entry = DenpaMenBackupEntry(denpaMen: _denpaMen('individual-1'));

      final context = buildContext(
        entries: [entry],
        loadIcons: (denpaMenId) async => {'icon': iconFile},
      );

      await CopyIconsStep().run(context);

      final wholeBodySlotDir = Directory(
        path.join(
          workDirectory.path,
          'icons',
          'denpamens',
          'individual-1',
          'wholeBody',
        ),
      );
      expect(await wholeBodySlotDir.exists(), isFalse);
    },
  );

  test(
    'routes each individual\'s images into that individual\'s own subdirectory',
    () async {
      final icon1 = await writeDummyPng('icon1.png');
      await icon1.writeAsBytes([1]);
      final icon2 = await writeDummyPng('icon2.png');
      await icon2.writeAsBytes([2]);
      final entries = [
        DenpaMenBackupEntry(denpaMen: _denpaMen('individual-1')),
        DenpaMenBackupEntry(denpaMen: _denpaMen('individual-2')),
      ];

      final context = buildContext(
        entries: entries,
        loadIcons: (denpaMenId) async => {
          'icon': denpaMenId == 'individual-1' ? icon1 : icon2,
        },
      );

      await CopyIconsStep().run(context);

      final copied1 = File(
        path.join(
          workDirectory.path,
          'icons',
          'denpamens',
          'individual-1',
          'icon',
          'icon.png',
        ),
      );
      final copied2 = File(
        path.join(
          workDirectory.path,
          'icons',
          'denpamens',
          'individual-2',
          'icon',
          'icon.png',
        ),
      );
      expect(await copied1.readAsBytes(), [1]);
      expect(await copied2.readAsBytes(), [2]);
    },
  );
}
