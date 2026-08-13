import 'dart:convert';

import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../../domain/master_data/abnormality_type.dart';
import '../../domain/master_data/anntena.dart';
import '../../domain/master_data/attribute.dart';
import '../../domain/master_data/attribute_bonus.dart';
import '../../domain/master_data/body_color_abnormality_resistance_rule.dart';
import '../../domain/master_data/body_color_resistance_rule.dart';
import '../../domain/master_data/correction.dart';
import '../../domain/master_data/head_shape.dart';
import '../../domain/master_data/master_data.dart';
import '../../domain/master_data/pattern.dart';
import '../../domain/master_data/personality.dart';
import '../../domain/master_data/physique.dart';
import 'asset_directory_loader.dart';

const _headShapesDirectoryPath = 'assets/data/head_shapes/';
const _antennasDirectoryPath = 'assets/data/antennas/';
const _elementalAttributesDirectoryPath = 'assets/data/attributes/elemental/';
const _specialAttributesDirectoryPath = 'assets/data/attributes/special/';
const _abnormalityTypesAssetPath = 'assets/data/abnormality_types.json';
const _bodyColorResistanceAssetPath =
    'assets/data/body_color_attribute_resistance.json';
const _bodyColorAbnormalityResistanceAssetPath =
    'assets/data/body_color_abnormality_resistance.json';
const _physiquesAssetPath = 'assets/data/physiques.json';
const _personalitiesAssetPath = 'assets/data/personalities.json';
const _patternsAssetPath = 'assets/data/patterns.json';
const _correctionsAssetPath = 'assets/data/corrections.json';
const _colorIdJsonKey = 'colorId';
const _attackAttributeIdsJsonKey = 'attackAttributeIds';
const _attributeResistanceBonusesJsonKey = 'attributeResistanceBonuses';
const _resistantToIdsJsonKey = 'resistantToIds';
const _weakToIdsJsonKey = 'weakToIds';

/// [MasterDataRepository] implementation backed by JSON files bundled as
/// Flutter assets under `assets/data/`. Each antenna, head shape and
/// attribute is its own file under `assets/data/antennas/` /
/// `assets/data/head_shapes/` / `assets/data/attributes/elemental|special/`,
/// loaded via [loadJsonEntitiesFromDirectory] instead of a single combined
/// list.
///
/// Attributes are loaded first, since antennas, head shapes and body color
/// resistance rules all resolve their attribute id references against the
/// resulting [Attribute] list.
class JsonMasterDataRepository implements MasterDataRepository {
  JsonMasterDataRepository({AssetBundle? bundle})
    : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;

  @override
  Future<MasterData> load() async {
    final baseElementalAttributes = await loadJsonEntitiesFromDirectory(
      bundle: _bundle,
      directoryPath: _elementalAttributesDirectoryPath,
      fromJson: (json) => Attribute.fromJson(json).copyWith(isElemental: true),
    );
    final baseSpecialAttributes = await loadJsonEntitiesFromDirectory(
      bundle: _bundle,
      directoryPath: _specialAttributesDirectoryPath,
      fromJson: (json) => Attribute.fromJson(json).copyWith(isElemental: false),
    );
    final baseAttributeById = {
      for (final attribute in [
        ...baseElementalAttributes,
        ...baseSpecialAttributes,
      ])
        attribute.id: attribute,
    };
    Attribute resolve(Map<String, dynamic> json, {required bool isElemental}) =>
        Attribute.fromJson(json).copyWith(
          isElemental: isElemental,
          resistantTo: _attributesFrom(
            json[_resistantToIdsJsonKey] as List<dynamic>?,
            baseAttributeById,
          ),
          weakTo: _attributesFrom(
            json[_weakToIdsJsonKey] as List<dynamic>?,
            baseAttributeById,
          ),
        );
    final elementalAttributes = await loadJsonEntitiesFromDirectory(
      bundle: _bundle,
      directoryPath: _elementalAttributesDirectoryPath,
      fromJson: (json) => resolve(json, isElemental: true),
    );
    final specialAttributes = await loadJsonEntitiesFromDirectory(
      bundle: _bundle,
      directoryPath: _specialAttributesDirectoryPath,
      fromJson: (json) => resolve(json, isElemental: false),
    );
    final attributes = [...elementalAttributes, ...specialAttributes];
    final attributeById = {
      for (final attribute in attributes) attribute.id: attribute,
    };

    final headShapes = await loadJsonEntitiesFromDirectory(
      bundle: _bundle,
      directoryPath: _headShapesDirectoryPath,
      fromJson: (json) => HeadShape.fromJson(json).copyWith(
        attributeResistanceBonuses: _attributeBonusesFrom(
          json[_attributeResistanceBonusesJsonKey] as Map<String, dynamic>?,
          attributeById,
        ),
      ),
    );
    final anntenas = await loadJsonEntitiesFromDirectory(
      bundle: _bundle,
      directoryPath: _antennasDirectoryPath,
      fromJson: (json) => Anntena.fromJson(json).copyWith(
        attackAttributes: _attributesFrom(
          json[_attackAttributeIdsJsonKey] as List<dynamic>?,
          attributeById,
        ),
      ),
      listPerFile: true,
    );
    final abnormalityTypes = await _loadList(
      _abnormalityTypesAssetPath,
      AbnormalityType.fromJson,
    );
    final bodyColorResistanceRules = await _loadKeyedByColorId(
      _bodyColorResistanceAssetPath,
      (json) => BodyColorResistanceRule.fromJson(json).copyWith(
        attributeResistanceBonuses: _attributeBonusesFrom(
          json[_attributeResistanceBonusesJsonKey] as Map<String, dynamic>?,
          attributeById,
        ),
      ),
    );
    final bodyColorAbnormalityResistanceRules = await _loadKeyedByColorId(
      _bodyColorAbnormalityResistanceAssetPath,
      BodyColorAbnormalityResistanceRule.fromJson,
    );
    final physiques = await _loadList(_physiquesAssetPath, Physique.fromJson);
    final personalities = await _loadList(
      _personalitiesAssetPath,
      Personality.fromJson,
    );
    final patterns = await _loadList(_patternsAssetPath, Pattern.fromJson);
    final corrections = await _loadList(
      _correctionsAssetPath,
      Correction.fromJson,
    );

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

  Future<List<T>> _loadList<T>(
    String assetPath,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final raw = await _bundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  Future<List<T>> _loadKeyedByColorId<T>(
    String assetPath,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final raw = await _bundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.entries
        .map(
          (entry) => fromJson({
            _colorIdJsonKey: entry.key,
            ...entry.value as Map<String, dynamic>,
          }),
        )
        .toList();
  }
}

/// Resolves a raw list of attribute ids (or null/omitted) against
/// [attributeById].
List<Attribute> _attributesFrom(
  List<dynamic>? ids,
  Map<String, Attribute> attributeById,
) => [for (final id in ids ?? const []) attributeById[id as String]!];

/// Resolves a raw `{attributeId: bonus}` map (or null/omitted) against
/// [attributeById].
List<AttributeBonus> _attributeBonusesFrom(
  Map<String, dynamic>? bonusesByAttributeId,
  Map<String, Attribute> attributeById,
) => [
  for (final entry in (bonusesByAttributeId ?? const {}).entries)
    (attribute: attributeById[entry.key]!, bonus: entry.value as int),
];
