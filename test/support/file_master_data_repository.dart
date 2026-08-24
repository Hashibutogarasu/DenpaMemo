import 'dart:convert';
import 'dart:io';

import 'package:denpa_memo/domain/master_data/abnormality_type.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/attribute.dart';
import 'package:denpa_memo/domain/master_data/attribute_bonus.dart';
import 'package:denpa_memo/domain/master_data/body_color_abnormality_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/body_color_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/correction.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';

/// Offline [MasterDataRepository] for widget/integration tests: reads the
/// same real game data the server seeds from, straight off disk at
/// `modules/server/data/`, instead of requiring a running GraphQL server.
///
/// This mirrors the deleted `JsonMasterDataRepository`'s parsing exactly,
/// just reading via `dart:io` (this repository only ever runs inside the
/// `flutter test` process, which has full filesystem access, not on a
/// device) rather than through an `AssetBundle`. Tests should not
/// construct this directly — use [testMasterDataRepositoryOverride] (see
/// `test_app.dart`) so every test shares one cached [MasterData] instead
/// of re-reading dozens of files per test.
class FileMasterDataRepository implements MasterDataRepository {
  FileMasterDataRepository({Directory? dataDir})
    : _dataDir = dataDir ?? _defaultDataDir();

  final Directory _dataDir;

  static Directory _defaultDataDir() {
    var dir = Directory.current;
    while (!File('${dir.path}/pubspec.yaml').existsSync()) {
      final parent = dir.parent;
      if (parent.path == dir.path) {
        throw StateError('Could not locate repo root from ${Directory.current.path}');
      }
      dir = parent;
    }
    return Directory('${dir.path}/modules/server/data');
  }

  /// Reads and parses everything synchronously (`dart:io`'s `*Sync`
  /// calls), even though the public [MasterDataRepository.load] contract
  /// is `Future`-returning: real asynchronous file I/O never completes
  /// under `flutter test`'s `FakeAsync` pump loop without wrapping every
  /// consuming test in `tester.runAsync()`, which the real
  /// `GraphqlMasterDataRepository` this stands in for doesn't need
  /// (network I/O is genuinely awaited by whatever mocks it in tests
  /// that do exercise it directly). Synchronous calls resolve within a
  /// single microtask, which `pump`/`pumpAndSettle` already handle fine.
  @override
  Future<MasterData> load() async {
    final baseElementalAttributes = _loadDirectory(
      'attributes/elemental',
      (json) => Attribute.fromJson(json).copyWith(isElemental: true),
    );
    final baseSpecialAttributes = _loadDirectory(
      'attributes/special',
      (json) => Attribute.fromJson(json).copyWith(isElemental: false),
    );
    final baseAttributeById = {
      for (final attribute in [...baseElementalAttributes, ...baseSpecialAttributes])
        attribute.id: attribute,
    };

    Attribute resolve(Map<String, dynamic> json, {required bool isElemental}) =>
        Attribute.fromJson(json).copyWith(
          isElemental: isElemental,
          resistantTo: _attributesFrom(
            json['resistantToIds'] as List<dynamic>?,
            baseAttributeById,
          ),
          weakTo: _attributesFrom(
            json['weakToIds'] as List<dynamic>?,
            baseAttributeById,
          ),
        );
    final elementalAttributes = _loadDirectory(
      'attributes/elemental',
      (json) => resolve(json, isElemental: true),
    );
    final specialAttributes = _loadDirectory(
      'attributes/special',
      (json) => resolve(json, isElemental: false),
    );
    final attributes = [...elementalAttributes, ...specialAttributes];
    final attributeById = {
      for (final attribute in attributes) attribute.id: attribute,
    };

    final headShapes = _loadDirectory(
      'head_shapes',
      (json) => HeadShape.fromJson(json).copyWith(
        attributeResistanceBonuses: _attributeBonusesFrom(
          json['attributeResistanceBonuses'] as Map<String, dynamic>?,
          attributeById,
        ),
      ),
    );
    final anntenas = _loadDirectory(
      'antennas',
      (json) => Anntena.fromJson(json).copyWith(
        attackAttributes: _attributesFrom(
          json['attackAttributeIds'] as List<dynamic>?,
          attributeById,
        ),
      ),
      listPerFile: true,
    );
    final abnormalityTypes = _loadList(
      'abnormality_types.json',
      AbnormalityType.fromJson,
    );
    final bodyColorResistanceRules = _loadKeyedByColorId(
      'body_color_attribute_resistance.json',
      (json) => BodyColorResistanceRule.fromJson(json).copyWith(
        attributeResistanceBonuses: _attributeBonusesFrom(
          json['attributeResistanceBonuses'] as Map<String, dynamic>?,
          attributeById,
        ),
      ),
    );
    final bodyColorAbnormalityResistanceRules = _loadKeyedByColorId(
      'body_color_abnormality_resistance.json',
      BodyColorAbnormalityResistanceRule.fromJson,
    );
    final physiques = _loadList('physiques.json', Physique.fromJson);
    final personalities = _loadList(
      'personalities.json',
      Personality.fromJson,
    );
    final patterns = _loadList('patterns.json', Pattern.fromJson);
    final corrections = _loadList('corrections.json', Correction.fromJson);

    return MasterData(
      headShapes: headShapes,
      anntenas: anntenas,
      attributes: attributes,
      abnormalityTypes: abnormalityTypes,
      bodyColorResistanceRules: bodyColorResistanceRules,
      bodyColorAbnormalityResistanceRules: bodyColorAbnormalityResistanceRules,
      physiques: physiques,
      personalities: personalities,
      patterns: patterns,
      corrections: corrections,
    );
  }

  List<T> _loadDirectory<T>(
    String relativeDirectoryPath,
    T Function(Map<String, dynamic> json) fromJson, {
    bool listPerFile = false,
  }) {
    final dir = Directory('${_dataDir.path}/$relativeDirectoryPath');
    final files =
        dir
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => file.path.endsWith('.json'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));

    final entities = <T>[];
    for (final file in files) {
      final decoded = jsonDecode(file.readAsStringSync());
      if (listPerFile) {
        entities.addAll(
          (decoded as List).map((e) => fromJson(e as Map<String, dynamic>)),
        );
      } else {
        entities.add(fromJson(decoded as Map<String, dynamic>));
      }
    }
    return entities;
  }

  List<T> _loadList<T>(
    String fileName,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    final raw = File('${_dataDir.path}/$fileName').readAsStringSync();
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded.map((entry) => fromJson(entry as Map<String, dynamic>)).toList();
  }

  List<T> _loadKeyedByColorId<T>(
    String fileName,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    final raw = File('${_dataDir.path}/$fileName').readAsStringSync();
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.entries
        .map(
          (entry) => fromJson({
            'colorId': entry.key,
            ...entry.value as Map<String, dynamic>,
          }),
        )
        .toList();
  }
}

List<Attribute> _attributesFrom(
  List<dynamic>? ids,
  Map<String, Attribute> attributeById,
) => [for (final id in ids ?? const []) attributeById[id as String]!];

List<AttributeBonus> _attributeBonusesFrom(
  Map<String, dynamic>? bonusesByAttributeId,
  Map<String, Attribute> attributeById,
) => [
  for (final entry in (bonusesByAttributeId ?? const {}).entries)
    (attribute: attributeById[entry.key]!, bonus: entry.value as int),
];
