import 'dart:convert';

import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../../domain/master_data/abnormality_type.dart';
import '../../domain/master_data/anntena.dart';
import '../../domain/master_data/attribute.dart';
import '../../domain/master_data/body_color_abnormality_resistance_rule.dart';
import '../../domain/master_data/body_color_resistance_rule.dart';
import '../../domain/master_data/head_shape.dart';
import '../../domain/master_data/master_data.dart';
import '../../domain/master_data/pattern.dart';
import '../../domain/master_data/personality.dart';
import '../../domain/master_data/physique.dart';
import 'asset_directory_loader.dart';

const _headShapesAssetPath = 'assets/data/head_shapes.json';
const _antennasDirectoryPath = 'assets/data/antennas/';
const _attributesAssetPath = 'assets/data/attributes.json';
const _abnormalityTypesAssetPath = 'assets/data/abnormality_types.json';
const _bodyColorResistanceAssetPath =
    'assets/data/body_color_attribute_resistance.json';
const _bodyColorAbnormalityResistanceAssetPath =
    'assets/data/body_color_abnormality_resistance.json';
const _physiquesAssetPath = 'assets/data/physiques.json';
const _personalitiesAssetPath = 'assets/data/personalities.json';
const _patternsAssetPath = 'assets/data/patterns.json';
const _colorIdJsonKey = 'colorId';

/// [MasterDataRepository] implementation backed by JSON files bundled as
/// Flutter assets under `assets/data/`. Each antenna is its own file under
/// `assets/data/antennas/`, loaded via [loadJsonEntitiesFromDirectory]
/// instead of a single combined list.
class JsonMasterDataRepository implements MasterDataRepository {
  JsonMasterDataRepository({AssetBundle? bundle})
    : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;

  @override
  Future<MasterData> load() async {
    final headShapes = await _loadList(
      _headShapesAssetPath,
      HeadShape.fromJson,
    );
    final anntenas = await loadJsonEntitiesFromDirectory(
      bundle: _bundle,
      directoryPath: _antennasDirectoryPath,
      fromJson: Anntena.fromJson,
    );
    final attributes = await _loadList(
      _attributesAssetPath,
      Attribute.fromJson,
    );
    final abnormalityTypes = await _loadList(
      _abnormalityTypesAssetPath,
      AbnormalityType.fromJson,
    );
    final bodyColorResistanceRules = await _loadKeyedByColorId(
      _bodyColorResistanceAssetPath,
      BodyColorResistanceRule.fromJson,
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
