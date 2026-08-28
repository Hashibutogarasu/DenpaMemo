import 'package:data_pack/data_pack.dart';
import 'package:test/test.dart';

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
    'buildDenpaMenBackupEntries pairs a selected individual with its referenced QR code',
    () {
      final qrCode = createQrCode('raw-value', name: 'group');
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
      ).copyWith(qrCodeId: qrCode.id);

      final entries = buildDenpaMenBackupEntries([denpaMen], [qrCode]);

      expect(entries, hasLength(1));
      expect(entries.single.denpaMen.id, denpaMen.id);
      expect(entries.single.qrCode, isNotNull);
      expect(entries.single.qrCode!.id, qrCode.id);
      expect(entries.single.qrCode!.rawValue, qrCode.rawValue);
      expect(entries.single.qrCode!.hash, qrCode.hash);
    },
  );

  test(
    'buildDenpaMenBackupEntries leaves qrCode null when the individual has none or it is not available',
    () {
      final withoutQrCode = createDenpaMen(
        name: 'no-qr',
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
      final withUnavailableQrCode = createDenpaMen(
        name: 'unavailable-qr',
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
      ).copyWith(qrCodeId: 'not-in-available-list');

      final entries = buildDenpaMenBackupEntries(
        [withoutQrCode, withUnavailableQrCode],
        const [],
      );

      expect(entries.every((e) => e.qrCode == null), isTrue);
    },
  );

  test(
    'buildDenpaMenBackupEntries only includes QR codes referenced by the given individuals',
    () {
      final referencedQrCode = createQrCode('raw-value-referenced', name: 'referenced');
      final unrelatedQrCode = createQrCode('raw-value-unrelated', name: 'unrelated');
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
      ).copyWith(qrCodeId: referencedQrCode.id);

      final entries = buildDenpaMenBackupEntries(
        [denpaMen],
        [referencedQrCode, unrelatedQrCode],
      );

      expect(entries.single.qrCode!.id, referencedQrCode.id);
    },
  );
}
