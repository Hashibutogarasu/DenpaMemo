import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/qr_code/objectbox_qr_code_repository.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_backup_entry.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_backup_merge.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/body_color_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';
import 'package:denpa_memo/domain/qr_code/qr_code_factory.dart';
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

  DenpaMen buildDenpaMen({
    String? id,
    String name = 'test-denpa-men',
    List<String> parentIds = const [],
    int? catchOrder,
  }) {
    return createDenpaMen(
      id: id,
      name: name,
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
      parentIds: parentIds,
      catchOrder: catchOrder,
    );
  }

  test('mergeDenpaMenBackupEntries updates existing cuid, inserts new cuid', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
    final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

    final existing = buildDenpaMen(name: 'original-name');
    denpaMenRepository.save(existing);
    final beforeCount = denpaMenRepository.getAll(masterData).length;

    final updated = existing.copyWith(name: 'updated-name');
    final brandNew = buildDenpaMen(name: 'brand-new');

    final results = mergeDenpaMenBackupEntries(
      [
        DenpaMenBackupEntry(denpaMen: updated),
        DenpaMenBackupEntry(denpaMen: brandNew),
      ],
      denpaMenRepository: denpaMenRepository,
      qrCodeRepository: qrCodeRepository,
      masterData: masterData,
    );

    expect(results.length, 2);
    expect(results[0].outcome, DenpaMenMergeOutcome.merged);
    expect(results[1].outcome, DenpaMenMergeOutcome.added);

    final all = denpaMenRepository.getAll(masterData);
    expect(all.length, beforeCount + 1);
    expect(
      all.firstWhere((r) => r.denpaMen.id == existing.id).denpaMen.name,
      'updated-name',
    );
    expect(all.any((r) => r.denpaMen.id == brandNew.id), isTrue);
  });

  test('mergeDenpaMenBackupEntries reuses an existing QR code by hash', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
    final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

    const rawValue = 'raw-value-reuses-existing-qr-code-by-hash';
    final existingQrCode = createQrCode(rawValue, name: 'existing');
    final existingIndividual = buildDenpaMen(name: 'existing-owner');
    qrCodeRepository.saveWithDenpaMens(
      existingQrCode,
      [existingIndividual],
      masterData,
    );
    final beforeQrCodeCount = qrCodeRepository.getAll().length;

    final importedQrCode = createQrCode(rawValue, name: 'imported');
    final importedIndividual = buildDenpaMen(name: 'imported-owner').copyWith(
      qrCodeId: importedQrCode.id,
    );

    final results = mergeDenpaMenBackupEntries(
      [DenpaMenBackupEntry(denpaMen: importedIndividual, qrCode: importedQrCode)],
      denpaMenRepository: denpaMenRepository,
      qrCodeRepository: qrCodeRepository,
      masterData: masterData,
    );

    expect(qrCodeRepository.getAll().length, beforeQrCodeCount);
    expect(results.single.denpaMen.qrCodeId, existingQrCode.id);
  });

  test('mergeDenpaMenBackupEntries inserts a new QR code when hash is unknown', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
    final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);
    final beforeQrCodeCount = qrCodeRepository.getAll().length;

    final newQrCode = createQrCode('raw-value-inserts-new-qr-code', name: 'new');
    final individual = buildDenpaMen().copyWith(qrCodeId: newQrCode.id);

    final results = mergeDenpaMenBackupEntries(
      [DenpaMenBackupEntry(denpaMen: individual, qrCode: newQrCode)],
      denpaMenRepository: denpaMenRepository,
      qrCodeRepository: qrCodeRepository,
      masterData: masterData,
    );

    expect(qrCodeRepository.getAll().length, beforeQrCodeCount + 1);
    expect(results.single.denpaMen.qrCodeId, newQrCode.id);
  });

  test('re-importing an unchanged export is idempotent', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
    final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

    final qrCode = createQrCode('raw-value-idempotent-reimport', name: 'group');
    final a = buildDenpaMen(name: 'a').copyWith(qrCodeId: qrCode.id);
    final b = buildDenpaMen(name: 'b');
    qrCodeRepository.saveWithDenpaMens(qrCode, [a], masterData);
    denpaMenRepository.save(b);

    final beforeDenpaMenCount = denpaMenRepository.getAll(masterData).length;
    final beforeQrCodeCount = qrCodeRepository.getAll().length;

    final exportedA = denpaMenRepository
        .getAll(masterData)
        .firstWhere((r) => r.denpaMen.id == a.id)
        .denpaMen;
    final exportedB = denpaMenRepository
        .getAll(masterData)
        .firstWhere((r) => r.denpaMen.id == b.id)
        .denpaMen;
    final entries = [
      DenpaMenBackupEntry(denpaMen: exportedA, qrCode: qrCode),
      DenpaMenBackupEntry(denpaMen: exportedB),
    ];

    mergeDenpaMenBackupEntries(
      entries,
      denpaMenRepository: denpaMenRepository,
      qrCodeRepository: qrCodeRepository,
      masterData: masterData,
    );

    expect(denpaMenRepository.getAll(masterData).length, beforeDenpaMenCount);
    expect(qrCodeRepository.getAll().length, beforeQrCodeCount);
    final reloadedA = denpaMenRepository
        .getAll(masterData)
        .firstWhere((r) => r.denpaMen.id == a.id);
    expect(reloadedA.denpaMen.name, 'a');
    expect(reloadedA.denpaMen.qrCodeId, qrCode.id);
  });

  test(
    'importing after deletion restores the individual and its QR link',
    () {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
      final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

      final qrCode = createQrCode('raw-value-restore-after-deletion', name: 'group');
      final deleted = buildDenpaMen(name: 'deleted').copyWith(qrCodeId: qrCode.id);
      final kept = buildDenpaMen(name: 'kept');
      qrCodeRepository.saveWithDenpaMens(qrCode, [deleted], masterData);
      denpaMenRepository.save(kept);
      final beforeQrCodeCount = qrCodeRepository.getAll().length;

      final backedUpDeleted = denpaMenRepository
          .getAll(masterData)
          .firstWhere((r) => r.denpaMen.id == deleted.id);
      final entry = DenpaMenBackupEntry(
        denpaMen: backedUpDeleted.denpaMen,
        qrCode: qrCode,
      );

      denpaMenRepository.delete(backedUpDeleted.id);
      expect(denpaMenRepository.findByCuid(deleted.id, masterData), isNull);

      mergeDenpaMenBackupEntries(
        [entry],
        denpaMenRepository: denpaMenRepository,
        qrCodeRepository: qrCodeRepository,
        masterData: masterData,
      );

      expect(qrCodeRepository.getAll().length, beforeQrCodeCount);
      final restored = denpaMenRepository.findByCuid(deleted.id, masterData);
      expect(restored, isNotNull);
      expect(restored!.denpaMen.qrCodeId, qrCode.id);
      final keptRecord = denpaMenRepository.findByCuid(kept.id, masterData);
      expect(keptRecord!.denpaMen.name, 'kept');
    },
  );

  test(
    'importing a deleted individual with no QR code and no parents restores it as-is',
    () {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
      final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

      final denpaMen = buildDenpaMen(name: 'isolated');
      final id = denpaMenRepository.save(denpaMen);
      final entry = DenpaMenBackupEntry(denpaMen: denpaMen);

      denpaMenRepository.delete(id);

      mergeDenpaMenBackupEntries(
        [entry],
        denpaMenRepository: denpaMenRepository,
        qrCodeRepository: qrCodeRepository,
        masterData: masterData,
      );

      final restored = denpaMenRepository.findByCuid(denpaMen.id, masterData);
      expect(restored, isNotNull);
      expect(restored!.denpaMen.qrCodeId, isNull);
      expect(restored.denpaMen.parentIds, isEmpty);
    },
  );

  test(
    'importing a deleted individual with an existing parent links to it',
    () {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
      final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

      final parentA = buildDenpaMen(name: 'parent-a');
      final parentB = buildDenpaMen(name: 'parent-b');
      denpaMenRepository.save(parentA);
      denpaMenRepository.save(parentB);
      final child = buildDenpaMen(
        name: 'child',
        parentIds: [parentA.id, parentB.id],
      );
      final childId = denpaMenRepository.save(child);
      final childEntry = DenpaMenBackupEntry(denpaMen: child);

      denpaMenRepository.delete(childId);

      mergeDenpaMenBackupEntries(
        [childEntry],
        denpaMenRepository: denpaMenRepository,
        qrCodeRepository: qrCodeRepository,
        masterData: masterData,
      );

      final restoredChild = denpaMenRepository.findByCuid(child.id, masterData);
      expect(restoredChild, isNotNull);
      expect(restoredChild!.denpaMen.parentIds, [parentA.id, parentB.id]);
      final resolvedParents = denpaMenRepository.getChildrens(
        restoredChild.denpaMen,
        masterData,
      );
      expect(
        resolvedParents.map((r) => r.denpaMen.id).toSet(),
        {parentA.id, parentB.id},
      );
    },
  );

  test(
    'importing a deleted individual whose parents are missing stays orphaned but does not throw',
    () {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
      final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

      final missingParentIds = ['missing-parent-a', 'missing-parent-b'];
      final child = buildDenpaMen(name: 'child', parentIds: missingParentIds);
      final childId = denpaMenRepository.save(child);
      final childEntry = DenpaMenBackupEntry(denpaMen: child);

      denpaMenRepository.delete(childId);

      expect(
        () => mergeDenpaMenBackupEntries(
          [childEntry],
          denpaMenRepository: denpaMenRepository,
          qrCodeRepository: qrCodeRepository,
          masterData: masterData,
        ),
        returnsNormally,
      );

      final restoredChild = denpaMenRepository.findByCuid(child.id, masterData);
      expect(restoredChild, isNotNull);
      expect(restoredChild!.denpaMen.parentIds, missingParentIds);
      expect(
        denpaMenRepository.findByCuid(missingParentIds.first, masterData),
        isNull,
      );
    },
  );
}
