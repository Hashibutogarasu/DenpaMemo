import 'package:data_pack/data_pack.dart';
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

  test('findByHash() returns the matching record, or null', () {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    final qrCodeRepository = ObjectBoxQrCodeRepository(objectBox);

    final qrCode = createQrCode('raw-value', name: 'group-name');
    qrCodeRepository.saveWithDenpaMens(qrCode, const [], masterData);

    final found = qrCodeRepository.findByHash(qrCode.hash);
    expect(found?.qrCode.id, qrCode.id);

    expect(qrCodeRepository.findByHash('unknown-hash'), isNull);
  });
}
