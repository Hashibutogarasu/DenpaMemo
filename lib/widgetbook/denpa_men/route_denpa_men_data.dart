import 'dart:convert';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/services.dart';

import 'denpa_men_data.dart';

/// Individuals loaded from `assets/routes/*.json`.
abstract final class RouteDenpaMenData {
  static const _assetPaths = ['assets/routes/mizuka.json', 'assets/routes/sanagi.json'];

  static late final Map<String, DenpaMen> byId;
  static late final List<DenpaMen> all;
  static late final MasterData masterData;

  static Future<void> initialize() async {
    final byId = <String, DenpaMen>{};

    void visit(Map<String, dynamic> node) {
      final denpaMen = DenpaMen.fromJson(node);
      if (byId.containsKey(denpaMen.id)) {
        return;
      }
      byId[denpaMen.id] = denpaMen;
      for (final parent in node['parents'] as List<dynamic>) {
        visit(parent as Map<String, dynamic>);
      }
    }

    for (final path in _assetPaths) {
      final raw = await rootBundle.loadString(path);
      visit(jsonDecode(raw) as Map<String, dynamic>);
    }

    RouteDenpaMenData.byId = byId;
    RouteDenpaMenData.all = byId.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    RouteDenpaMenData.masterData = _harvestMasterData(RouteDenpaMenData.all);
  }

  static MasterData _harvestMasterData(List<DenpaMen> individuals) {
    final fixture = DenpaMenData.masterData;
    final headShapes = {for (final h in fixture.headShapes) h.id: h};
    final physiques = {for (final p in fixture.physiques) p.id: p};
    final personalities = {for (final p in fixture.personalities) p.id: p};
    final patterns = {for (final p in fixture.patterns) p.id: p};
    final anntenas = {for (final a in fixture.anntenas) a.id: a};
    final attributes = {for (final a in fixture.attributes) a.id: a};
    final colorIds = {
      for (final rule in fixture.bodyColorResistanceRules) rule.colorId,
    };

    for (final denpaMen in individuals) {
      headShapes[denpaMen.headShape.id] = denpaMen.headShape;
      physiques[denpaMen.physique.id] = denpaMen.physique;
      personalities[denpaMen.personality.id] = denpaMen.personality;
      patterns[denpaMen.pattern.id] = denpaMen.pattern;
      anntenas[denpaMen.anntena.id] = denpaMen.anntena;
      colorIds.addAll(denpaMen.bodyColors);
      for (final resistance in denpaMen.attributeResistance) {
        attributes[resistance.attribute.id] = resistance.attribute;
      }
    }

    return MasterData(
      headShapes: headShapes.values.toList(),
      anntenas: anntenas.values.toList(),
      attributes: attributes.values.toList(),
      abnormalityTypes: fixture.abnormalityTypes,
      bodyColorResistanceRules: [
        for (final colorId in colorIds)
          BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: const []),
      ],
      bodyColorAbnormalityResistanceRules: fixture.bodyColorAbnormalityResistanceRules,
      physiques: physiques.values.toList(),
      personalities: personalities.values.toList(),
      patterns: patterns.values.toList(),
      corrections: fixture.corrections,
    );
  }
}
