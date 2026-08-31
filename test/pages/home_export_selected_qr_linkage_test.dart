import 'package:data_pack/data_pack.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/qr_code/objectbox_qr_code_repository.dart';

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
    attributes: const [Attribute(id: 'fire', index: 0)],
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

  test(
    'building export entries the way Home._exportSelected reads its data '
    '(direct repository.getAll() calls) keeps the QR code linked to a '
    'selected individual',
    () {
      final objectBox = ObjectBox.createInMemory();
      addTearDown(objectBox.store.close);
      final denpaMenRepository = ObjectBoxDenpaMenRepository(objectBox);
      final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

      final qrCode = createQrCode('raw-value-export-race');
      qrCodeRepository.saveWithDenpaMens(qrCode, const [], masterData);

      final denpaMen = createDenpaMen(
        name: 'individual-a',
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
      ).copyWith(qrCodeId: qrCode.id);
      denpaMenRepository.save(denpaMen);

      final records = denpaMenRepository.getAll(masterData);
      final qrCodes = qrCodeRepository.getAll();
      final entries = buildDenpaMenBackupEntries(
        [for (final record in records) record.denpaMen],
        [for (final record in qrCodes) record.qrCode],
      );

      expect(
        entries.single.qrCode,
        isNotNull,
        reason:
            'the QR code genuinely exists and is referenced by the '
            'exported individual, so the export must include it — '
            'losing it here is exactly what makes the imported individual '
            'invisible in the destination lineage tree',
      );
    },
  );
}
