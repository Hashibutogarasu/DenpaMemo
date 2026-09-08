import 'package:data_pack/data_pack.dart';
import 'package:test/test.dart';

DenpaMen _denpaMen({
  required String id,
  List<String> parentIds = const [],
  String? qrCodeId,
  int? catchOrder,
}) {
  return DenpaMen(
    id: id,
    name: id,
    abnormalityResistances: const [],
    bodyColors: const ['color'],
    attributeResistance: const [],
    physique: const Physique(id: 'physique'),
    personality: const Personality(id: 'personality'),
    pattern: const Pattern(id: 'pattern'),
    headShape: const HeadShape(id: 'head', abnormalityResistanceBonuses: {}),
    anntena: const Anntena(id: 'anntena', category: AnntenaCategory.other),
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
    parentIds: parentIds,
    qrCodeId: qrCodeId,
  );
}

QrCode _qrCode(String id) =>
    QrCode(id: id, rawValue: id, hash: id, createdAt: DateTime(2026));

void main() {
  test('two roots from the same QR breed straight into the target', () {
    final qr = _qrCode('qr-1');
    final rootA = _denpaMen(id: 'a', qrCodeId: qr.id, catchOrder: 0);
    final rootB = _denpaMen(id: 'b', qrCodeId: qr.id, catchOrder: 1);
    final target = _denpaMen(id: 't', parentIds: ['a', 'b']);

    final records = [
      DenpaMenRecord(id: 1, denpaMen: rootA),
      DenpaMenRecord(id: 2, denpaMen: rootB),
      DenpaMenRecord(id: 3, denpaMen: target),
    ];
    final qrCodes = [QrCodeRecord(id: 1, qrCode: qr)];

    final steps = buildBirthGuideSteps(
      target: records.last,
      allDenpaMen: records,
      allQrCodes: qrCodes,
    );

    expect(steps, hasLength(2));
    final catchStep = steps[0] as BirthGuideCatchStep;
    expect(catchStep.qrCode.qrCode.id, 'qr-1');
    expect(catchStep.individuals.map((r) => r.denpaMen.id), ['a', 'b']);

    final breedStep = steps[1] as BirthGuideBreedStep;
    expect(breedStep.individual.denpaMen.id, 't');
    expect(breedStep.parentA.denpaMen.id, 'a');
    expect(breedStep.parentB.denpaMen.id, 'b');
  });

  test('deeper lineage resolves in dependency order', () {
    final qrC = _qrCode('qr-c');
    final qrD = _qrCode('qr-d');
    final qrE = _qrCode('qr-e');
    final rootC = _denpaMen(id: 'c', qrCodeId: qrC.id, catchOrder: 0);
    final rootD = _denpaMen(id: 'd', qrCodeId: qrD.id, catchOrder: 0);
    final mid = _denpaMen(id: 'mid', parentIds: ['c', 'd']);
    final rootE = _denpaMen(id: 'e', qrCodeId: qrE.id, catchOrder: 0);
    final target = _denpaMen(id: 't', parentIds: ['mid', 'e']);

    final records = [
      DenpaMenRecord(id: 1, denpaMen: rootC),
      DenpaMenRecord(id: 2, denpaMen: rootD),
      DenpaMenRecord(id: 3, denpaMen: mid),
      DenpaMenRecord(id: 4, denpaMen: rootE),
      DenpaMenRecord(id: 5, denpaMen: target),
    ];
    final qrCodes = [
      QrCodeRecord(id: 1, qrCode: qrC),
      QrCodeRecord(id: 2, qrCode: qrD),
      QrCodeRecord(id: 3, qrCode: qrE),
    ];

    final steps = buildBirthGuideSteps(
      target: records.last,
      allDenpaMen: records,
      allQrCodes: qrCodes,
    );

    expect(steps, hasLength(5));
    expect(steps[0], isA<BirthGuideCatchStep>());
    expect(steps[1], isA<BirthGuideCatchStep>());
    final midStep = steps[2] as BirthGuideBreedStep;
    expect(midStep.individual.denpaMen.id, 'mid');
    expect(steps[3], isA<BirthGuideCatchStep>());
    final finalStep = steps[4] as BirthGuideBreedStep;
    expect(finalStep.individual.denpaMen.id, 't');
    expect(finalStep.parentA.denpaMen.id, 'mid');
    expect(finalStep.parentB.denpaMen.id, 'e');
  });

  test('roots sharing a QR across different branches are grouped once', () {
    final sharedQr = _qrCode('qr-shared');
    final rootA = _denpaMen(id: 'a', qrCodeId: sharedQr.id, catchOrder: 0);
    final rootF = _denpaMen(id: 'f', qrCodeId: sharedQr.id, catchOrder: 1);
    final rootX = _denpaMen(id: 'x', qrCodeId: 'qr-x', catchOrder: 0);
    final rootY = _denpaMen(id: 'y', qrCodeId: 'qr-y', catchOrder: 0);
    final midX = _denpaMen(id: 'midX', parentIds: ['a', 'x']);
    final midY = _denpaMen(id: 'midY', parentIds: ['f', 'y']);
    final target = _denpaMen(id: 't', parentIds: ['midX', 'midY']);

    final records = [
      DenpaMenRecord(id: 1, denpaMen: rootA),
      DenpaMenRecord(id: 2, denpaMen: rootF),
      DenpaMenRecord(id: 3, denpaMen: rootX),
      DenpaMenRecord(id: 4, denpaMen: rootY),
      DenpaMenRecord(id: 5, denpaMen: midX),
      DenpaMenRecord(id: 6, denpaMen: midY),
      DenpaMenRecord(id: 7, denpaMen: target),
    ];
    final qrCodes = [
      QrCodeRecord(id: 1, qrCode: sharedQr),
      QrCodeRecord(id: 2, qrCode: _qrCode('qr-x')),
      QrCodeRecord(id: 3, qrCode: _qrCode('qr-y')),
    ];

    final steps = buildBirthGuideSteps(
      target: records.last,
      allDenpaMen: records,
      allQrCodes: qrCodes,
    );

    final catchSteps = steps.whereType<BirthGuideCatchStep>().toList();
    final sharedCatchSteps = catchSteps.where(
      (step) => step.qrCode.qrCode.id == 'qr-shared',
    );
    expect(sharedCatchSteps, hasLength(1));
    expect(sharedCatchSteps.single.individuals.map((r) => r.denpaMen.id), [
      'a',
      'f',
    ]);
  });

  test('throws BirthGuideResolutionException for a missing parent id', () {
    final target = _denpaMen(id: 't', parentIds: ['missing-a', 'missing-b']);
    final records = [DenpaMenRecord(id: 1, denpaMen: target)];

    expect(
      () => buildBirthGuideSteps(
        target: records.single,
        allDenpaMen: records,
        allQrCodes: const [],
      ),
      throwsA(isA<BirthGuideResolutionException>()),
    );
  });
}
