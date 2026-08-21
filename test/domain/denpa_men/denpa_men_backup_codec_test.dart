import 'dart:convert';

import 'package:denpa_memo/domain/backup/dm_import_error.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_backup_codec.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_backup_entry.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/body_color_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';
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

  DenpaMenBackupEntry buildEntry(String name) {
    final denpaMen = createDenpaMen(
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
    );
    return DenpaMenBackupEntry(denpaMen: denpaMen);
  }

  test('encode/decode round-trips a valid entry array', () {
    final entries = [buildEntry('a'), buildEntry('b')];
    final source = jsonEncode(encodeDenpaMenBackup(entries));

    final result = decodeDenpaMenBackup(source);

    expect(result, isNotNull);
    expect(result!.entries.length, 2);
    expect(result.failed, isEmpty);
    expect(result.entries.map((e) => e.denpaMen.name), ['a', 'b']);
  });

  test('decodeDenpaMenBackup returns null for non-JSON input', () {
    expect(decodeDenpaMenBackup('not json'), isNull);
  });

  test('decodeDenpaMenBackup returns null when the top level is not an array', () {
    expect(decodeDenpaMenBackup(jsonEncode({'foo': 'bar'})), isNull);
  });

  test(
    'decodeDenpaMenBackup keeps valid entries and records a failed one',
    () {
      final validEntries = [buildEntry('a'), buildEntry('b')];
      final raw = [
        ...encodeDenpaMenBackup(validEntries),
        {'denpaMen': 'not-an-object'},
      ];
      final source = jsonEncode(raw);

      final result = decodeDenpaMenBackup(source);

      expect(result, isNotNull);
      expect(result!.entries.length, 2);
      expect(result.failed.length, 1);
      expect(result.failed.single, isA<DenpaMenEntryParseError>());
      expect(result.failed.single.index, 2);
    },
  );
}
