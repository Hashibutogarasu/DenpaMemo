import 'package:data_pack/data_pack.dart';
import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/qr_code/objectbox_qr_code_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final headShape = const HeadShape(id: 'head-a');
  final anntena = const Anntena(id: 'anntena-a', category: AnntenaCategory.other);
  final physique = const Physique(id: 'physique-a');
  final personality = const Personality(id: 'personality-a');
  final pattern = const Pattern(id: 'pattern-a');
  final colorId = 'color-a';

  final masterData = MasterData(
    headShapes: [headShape],
    anntenas: [anntena],
    attributes: const [],
    abnormalityTypes: const [],
    physiques: [physique],
    personalities: [personality],
    patterns: [pattern],
    bodyColorResistanceRules: [
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: const []),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  test(
    'save() keeps the qrCode link intact when re-saving an edited individual',
    () {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
      final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

      final denpaMen = createDenpaMen(
        name: 'test-denpa-men',
        bodyColors: [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
        catchOrder: 0,
      );
      final qrCode = createQrCode('raw-value', name: 'group-name');
      qrCodeRepository.saveWithDenpaMens(qrCode, [denpaMen], masterData);

      final saved = denpaMenRepository
          .getAll(masterData)
          .firstWhere((record) => record.denpaMen.id == denpaMen.id);
      expect(saved.denpaMen.qrCodeId, qrCode.id);

      final edited = saved.denpaMen.copyWith(name: 'renamed');
      denpaMenRepository.save(edited, id: saved.id);

      final resaved = denpaMenRepository
          .getAll(masterData)
          .firstWhere((record) => record.denpaMen.id == denpaMen.id);
      expect(resaved.denpaMen.name, 'renamed');
      expect(resaved.denpaMen.qrCodeId, qrCode.id);
    },
  );

  test('save() persists considerCorrections across reloads', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);

    final denpaMen = createDenpaMen(
      name: 'test-denpa-men',
      bodyColors: [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
      considerCorrections: false,
    );
    final id = denpaMenRepository.save(denpaMen);

    final reloaded = denpaMenRepository
        .getAll(masterData)
        .firstWhere((record) => record.id == id);
    expect(reloaded.denpaMen.considerCorrections, isFalse);

    final edited = reloaded.denpaMen.copyWith(name: 'renamed');
    denpaMenRepository.save(edited, id: reloaded.id);

    final resaved = denpaMenRepository
        .getAll(masterData)
        .firstWhere((record) => record.id == id);
    expect(resaved.denpaMen.considerCorrections, isFalse);
  });

  test('findByCuid() returns the matching record, or null', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);

    final denpaMen = createDenpaMen(
      name: 'test-denpa-men',
      bodyColors: [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );
    final id = denpaMenRepository.save(denpaMen);

    final found = denpaMenRepository.findByCuid(denpaMen.id, masterData);
    expect(found?.id, id);
    expect(found?.denpaMen.id, denpaMen.id);

    expect(denpaMenRepository.findByCuid('unknown-cuid', masterData), isNull);
  });

  test(
    'watchAll() emits an update after a QR-code-linked individual is saved '
    'via the two-step saveWithDenpaMens(empty) + save() sequence used by '
    'mergeDenpaMenBackupEntries',
    () async {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
      final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

      final emissions = <List<int>>[];
      final subscription = denpaMenRepository
          .watchAll(masterData)
          .listen((records) => emissions.add([for (final r in records) r.id]));
      await pumpEventQueue();
      expect(emissions, hasLength(1), reason: 'the initial watch must emit once');
      final beforeIds = emissions.single.toSet();

      final qrCode = createQrCode('raw-value-watch-all', name: 'group');
      qrCodeRepository.saveWithDenpaMens(qrCode, const [], masterData);
      final denpaMen = createDenpaMen(
        name: 'watch-all-individual',
        bodyColors: [colorId],
        isSpColor: false,
        headShape: headShape,
        physique: physique,
        personality: personality,
        pattern: pattern,
        anntena: anntena,
        masterData: masterData,
        maxHappiness: 0,
        maxLevel: 1,
      ).copyWith(qrCodeId: qrCode.id);
      final id = denpaMenRepository.save(denpaMen);
      await pumpEventQueue();

      await subscription.cancel();

      expect(
        emissions.length,
        greaterThan(1),
        reason: 'watchAll() must emit again after '
            'saveWithDenpaMens(qrCode, const [], masterData) followed by '
            'save(denpaMen) — the exact sequence mergeDenpaMenBackupEntries '
            'uses when importing a new QR code.',
      );
      expect(
        emissions.last.toSet(),
        {...beforeIds, id},
        reason: 'the latest emission must include the newly-linked '
            'individual alongside whatever was already present',
      );

      final savedRecord = denpaMenRepository.findByCuid(denpaMen.id, masterData);
      expect(savedRecord!.denpaMen.qrCodeId, qrCode.id);
    },
  );
}
