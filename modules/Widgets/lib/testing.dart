import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:data_pack/data_pack.dart';

import 'i18n/gen/strings.g.dart';
import 'src/responsive/responsive_scope.dart';
import 'src/theme/app_button_theme.dart';
import 'src/theme/back_button_theme.dart';
import 'src/theme/denpa_men_container_theme.dart';
import 'src/theme/denpa_men_label_theme.dart';
import 'src/theme/dialog_transition_theme.dart';
import 'src/theme/fab_button_theme.dart';
import 'src/theme/fab_label_theme.dart';
import 'src/theme/list_item_container_theme.dart';
import 'src/theme/navigation_bar_blur_theme.dart';
import 'src/theme/slanted_header_theme.dart';
import 'src/theme/toggle_button_group_theme.dart';

/// The theme every widget/Widgetbook test in this package should render
/// under, so individual tests don't each assemble their own ad hoc
/// `ThemeData`/`extensions` — they all share one theme, matching how the
/// real app's own theme is one `ThemeData(...)` shared by the whole app.
/// Kept in sync with `lib/main.dart`'s theme in the `denpa_memo` app.
final ColorScheme _testColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
);

final ThemeData testAppTheme = ThemeData(
  colorScheme: _testColorScheme,
  listTileTheme: const ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
  ),
  dialogTheme: const DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    indicatorColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
  ),
  extensions: [
    const SlantedHeaderThemeData(
      fillColor: Color(0xFF52BBE5),
      borderColor: Color(0xFF0865C2),
      borderWidth: 6,
      angleDegrees: 10,
      contentPadding: EdgeInsets.only(left: 20, top: 8, right: 8),
    ),
    FabButtonThemeData(
      barrierColor: Colors.black54,
      scrimAnimationDuration: Duration(milliseconds: 200),
      scrimAnimationCurve: Curves.easeOutCubic,
      mainButtonAnimationDuration: Duration(milliseconds: 200),
      miniOptionSlideCurve: Curves.easeOutCubic,
      miniOptionSlideOffset: Offset(0, 0.3),
      labelBubbleElevation: 4,
      labelBubbleBorderRadius: 8,
      labelBubblePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      miniOptionGap: 12,
      miniOptionRowBottomPadding: 12,
    ),
    DenpaMenContainerThemeData(
      statusBackgroundColor: Color(0xFF90E2FF),
      statusBorderRadius: 20,
      nestedBackgroundColor: Color(0xFFC8E0E7),
      nestedBorderColor: Color(0xFF90DAFE),
      nestedBorderWidth: 2,
      nestedBorderRadius: 20,
      accentColor: Color(0xFF056193),
      memoBackgroundColor: Colors.white,
      memoBorderRadius: 4,
      headerDividerHeight: 2,
      pencilIconSize: 28,
      previewIconSize: 56,
      accordionIconSize: 32,
      accordionTitleFontSize: 20,
      accordionCheckboxSlotSize: 40,
      accordionAnimationDuration: Duration(milliseconds: 200),
      resistanceGap: 5,
      nameFieldFillColor: Colors.white,
    ),
    const DenpaMenLabelThemeData(
      headerTitleOutlineColor: Color(0xFF238BCB),
      pillBackgroundColor: Color(0xFF7FC9FF),
      pillTextColor: Color(0xFF2B2031),
      expBarFilledColor: Color(0xFFFFEB3B),
      expBarUnfilledColor: Color(0xFF056193),
      maxedValueColor: Color(0xFF7BEA95),
      inactiveBonusColor: Color(0xFFE53935),
      titleFillColor: Colors.white,
      expBarBorderColor: Colors.black,
    ),
    const AppButtonThemeData(
      backgroundTintColor: Color(0x995B7FA6),
      blurSigma: 12,
      foregroundColor: Colors.white,
    ),
    ToggleButtonGroupThemeData(
      containerColor: _testColorScheme.surface,
      containerElevation: 4,
      containerBorderRadius: 22,
      highlightColor: const Color(0xFF7FC9FF),
      highlightBorderRadius: 20,
      selectedIconColor: const Color(0xFF056193),
      unselectedIconColor: _testColorScheme.onSurfaceVariant,
      slideDuration: const Duration(milliseconds: 220),
      slideCurve: Curves.easeOutBack,
    ),
    ListItemContainerThemeData(
      backgroundColor: Color.alphaBlend(
        const Color(0x1452BBE5),
        _testColorScheme.surface,
      ),
      borderRadius: 20,
      tileBorderColor: _testColorScheme.outlineVariant,
      tileBorderWidth: 1,
      selectedBackgroundColor: Color.alphaBlend(
        const Color(0x33052744),
        _testColorScheme.surface,
      ),
      checkAnimationDuration: const Duration(milliseconds: 200),
      checkAnimationInCurve: Curves.easeOut,
      checkAnimationOutCurve: Curves.easeIn,
    ),
    NavigationBarBlurThemeData(
      tintColor: Colors.white.withValues(alpha: 0.5),
      blurSigma: 12,
    ),
    const BackButtonThemeData(anchor: BackButtonAnchor.bottomLeft),
    const FabLabelThemeData(showLabel: false, showTooltip: true),
    const DialogTransitionThemeData(
      duration: Duration(milliseconds: 220),
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
      beginOffset: Offset(0, 0.15),
    ),
  ],
);

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
