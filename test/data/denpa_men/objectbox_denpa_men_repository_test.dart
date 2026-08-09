import 'package:denpa_memo/data/denpa_men/objectbox_denpa_men_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/data/qr_code/objectbox_qr_code_repository.dart';
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
  final anntena = const Anntena(id: 'anntena-a');
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
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: const {}),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  test(
    'save() keeps the qrCode link intact when re-saving an edited individual',
    () {
      final objectBox = ObjectBox.createInMemory();
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

      final saved = denpaMenRepository.getAll(masterData).single;
      expect(saved.denpaMen.qrCodeId, qrCode.id);

      // Simulate editing the individual (e.g. renaming it) and saving again
      // through the plain single-edit path, which previously dropped the
      // qrCode ToOne relation since it always builds a fresh entity.
      final edited = saved.denpaMen.copyWith(name: 'renamed');
      denpaMenRepository.save(edited, id: saved.id);

      final resaved = denpaMenRepository.getAll(masterData).single;
      expect(resaved.denpaMen.name, 'renamed');
      expect(resaved.denpaMen.qrCodeId, qrCode.id);
    },
  );
}
