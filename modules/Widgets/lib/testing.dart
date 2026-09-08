import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:data_pack/data_pack.dart';

import 'i18n/gen/strings.g.dart';
import 'src/responsive/responsive_scope.dart';
import 'src/theme/app_theme_builder.dart';

/// [AppPalette] mirroring `AppLightTheme`'s palette in the `denpa_memo`
/// app's `lib/theme/app_theme.dart` — duplicated as literals because this
/// package cannot depend on the root app package. Keep these values in sync
/// by hand whenever `AppLightTheme`'s palette changes.
const _testPalette = AppPalette(
  settingsContainerLightnessDelta: -0.05,
  selectedItemLightnessDelta: -0.08,
  statusBackgroundColor: Color(0xFF90E2FF),
  nestedBorderColor: Color(0xFF90DAFE),
  expBarBorderColor: Colors.black,
  splashBackgroundColor: Color(0xFFF3EDF7),
  legendGridHighlightBorderColor: Color(0xFFE53935),
  legendGridDimmedBackgroundColor: Color(0x14000000),
  navigationBarTintColor: Color(0x80FFFFFF),
);

/// The theme every widget/Widgetbook test in this package should render
/// under, so individual tests don't each assemble their own ad hoc
/// `ThemeData`/`extensions` — they all share one theme, matching how the
/// real app's own theme is one `ThemeData(...)` shared by the whole app.
/// Built from the same [buildAppTheme] the real app calls, so this is
/// byte-for-byte the app's standard-contrast light theme rather than a
/// hand-copied stand-in.
final ThemeData testAppTheme = buildAppTheme(Brightness.light, _testPalette);

/// Wraps [home] with this package's [TranslationProvider], a
/// [ResponsiveScope], and a [MaterialApp] using [testAppTheme], for widget
/// tests to pump instead of building their own `MaterialApp`.
class TestApp extends StatelessWidget {
  const TestApp({super.key, required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MaterialApp(
        theme: testAppTheme,
        home: home,
        builder: (context, child) => ResponsiveScope(child: child!),
      ),
    );
  }
}

/// Minimal hand-built [MasterData] and sample [DenpaMen] for use in
/// Widgetbook use cases and tests, so they render without a live GraphQL
/// server.
abstract final class DenpaMenData {
  static const anntena = Anntena(
    id: 'antenna',
    category: AnntenaCategory.other,
  );
  static const headShape = HeadShape(id: 'head');
  static const physique = Physique(id: 'physique');
  static const personality = Personality(id: 'personality');
  static const pattern = Pattern(id: 'pattern');
  static const colorId = 'color';

  static final masterData = MasterData(
    headShapes: const [headShape],
    anntenas: const [anntena],
    attributes: const [Attribute(id: 'fire', index: 0)],
    abnormalityTypes: const <AbnormalityType>[],
    physiques: const [physique],
    personalities: const [personality],
    patterns: const [pattern],
    bodyColorResistanceRules: const [
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: []),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  static DenpaMen build(
    String name, {
    String? id,
    int? catchOrder,
    List<String> parentIds = const [],
  }) {
    return createDenpaMen(
      id: id,
      name: name,
      bodyColors: const [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: anntena,
      masterData: masterData,
      maxHappiness: 100,
      happiness: 50,
      level: 5,
      maxLevel: 30,
      hp: 40,
      ap: 30,
      attack: 20,
      defense: 18,
      speed: 12,
      evasionRate: 5,
      catchOrder: catchOrder,
      parentIds: parentIds,
    );
  }

  static final denpaMen = build('こうた', id: 'denpa-1', catchOrder: 1);

  static final denpaMenRecord = DenpaMenRecord(id: 1, denpaMen: denpaMen);
}

/// Individuals loaded from `assets/routes/*.json`. The caller's own
/// pubspec.yaml must declare `assets/routes/` for [initialize] to find
/// them at runtime.
abstract final class RouteDenpaMenData {
  static const _assetPaths = [
    'assets/routes/mizuka.json',
    'assets/routes/sanagi.json',
  ];

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
          BodyColorResistanceRule(
            colorId: colorId,
            attributeResistanceBonuses: const [],
          ),
      ],
      bodyColorAbnormalityResistanceRules:
          fixture.bodyColorAbnormalityResistanceRules,
      physiques: physiques.values.toList(),
      personalities: personalities.values.toList(),
      patterns: patterns.values.toList(),
      corrections: fixture.corrections,
    );
  }
}

/// Sample [QrCode] data for Widgetbook use cases and tests.
abstract final class QrCodeData {
  static final QrCode qrCode = createQrCode(
    'widgetbook-qr',
    id: 'qr-1',
    createdAt: DateTime(2026, 1, 1),
  );

  static final qrCodeRecord = QrCodeRecord(id: 1, qrCode: qrCode);
}
