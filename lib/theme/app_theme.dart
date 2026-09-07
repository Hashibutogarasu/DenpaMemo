import 'package:flutter/material.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart';

abstract final class AppCommonTheme {
  static const ListTileThemeData listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
  );

  static const NavigationBarThemeData navigationBarTheme =
      NavigationBarThemeData(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      );
}

/// Every value [_buildTheme] needs that isn't derivable from
/// [ColorScheme.fromSeed] alone, and instead differs by hand between light
/// and dark. [AppLightTheme] and [AppDarkTheme] each supply their own
/// constant instance, so the shared builder never branches on brightness
/// itself — it only ever reads `palette.someField`.
class _AppPalette {
  const _AppPalette({
    required this.settingsContainerLightnessDelta,
    required this.selectedItemLightnessDelta,
    required this.statusBackgroundColor,
    required this.nestedBorderColor,
    required this.expBarBorderColor,
    required this.splashBackgroundColor,
    required this.legendGridHighlightBorderColor,
    required this.legendGridDimmedBackgroundColor,
    required this.navigationBarTintColor,
  });

  final double settingsContainerLightnessDelta;
  final double selectedItemLightnessDelta;
  final Color statusBackgroundColor;
  final Color nestedBorderColor;
  final Color expBarBorderColor;
  final Color splashBackgroundColor;
  final Color legendGridHighlightBorderColor;
  final Color legendGridDimmedBackgroundColor;
  final Color navigationBarTintColor;
}

abstract final class AppLightTheme {
  static const _palette = _AppPalette(
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

  static final ThemeData theme = _buildTheme(Brightness.light, _palette);
}

abstract final class AppDarkTheme {
  static const _palette = _AppPalette(
    settingsContainerLightnessDelta: 0.12,
    selectedItemLightnessDelta: 0.12,
    statusBackgroundColor: Color(0xFF3E6E86),
    nestedBorderColor: Color(0xFF3B5F70),
    expBarBorderColor: Colors.white70,
    splashBackgroundColor: Color(0xFF1D1B20),
    legendGridHighlightBorderColor: Color(0xFFEF5350),
    legendGridDimmedBackgroundColor: Color(0x1FFFFFFF),
    navigationBarTintColor: Color(0x80000000),
  );

  static final ThemeData theme = _buildTheme(Brightness.dark, _palette);
}

ThemeData _buildTheme(Brightness brightness, _AppPalette palette) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: brightness,
  );
  final buttonTheme = AppButtonThemeData(
    backgroundTintColor: const Color(0x995B7FA6),
    blurSigma: 12,
    foregroundColor: Colors.white,
  );
  final settingsContainerColor = _settingsContainerColor(
    colorScheme,
    palette.settingsContainerLightnessDelta,
  );
  final listItemSelectedColor = _lightnessShifted(
    settingsContainerColor,
    palette.selectedItemLightnessDelta,
  );

  return ThemeData(
    colorScheme: colorScheme,
    listTileTheme: AppCommonTheme.listTileTheme,
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        side: BorderSide(color: listItemSelectedColor, width: 5),
      ),
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: _lightnessShifted(settingsContainerColor, 0.05),
    ),
    navigationBarTheme: AppCommonTheme.navigationBarTheme,
    filledButtonTheme: FilledButtonThemeData(
      style: _frostedButtonStyle(buttonTheme),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _frostedButtonStyle(buttonTheme),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF3B5B8C),
      foregroundColor: buttonTheme.foregroundColor,
      shape: const StadiumBorder(),
    ),
    extensions: [
      const SlantedHeaderThemeData(
        fillColor: Color(0xFF52BBE5),
        borderColor: Color(0xFF0865C2),
        borderWidth: 6,
        angleDegrees: 10,
        contentPadding: EdgeInsets.only(left: 20, top: 8, right: 8),
      ),
      const FabButtonThemeData(
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
        statusBackgroundColor: palette.statusBackgroundColor,
        statusBorderRadius: 20,
        nestedBackgroundColor: settingsContainerColor,
        nestedBorderColor: palette.nestedBorderColor,
        nestedBorderWidth: 2,
        nestedBorderRadius: 20,
        accentColor: const Color(0xFF056193),
        memoBackgroundColor: Colors.white,
        memoBorderRadius: 4,
        headerDividerHeight: 2,
        pencilIconSize: 28,
        previewIconSize: 56,
        accordionIconSize: 32,
        accordionTitleFontSize: 20,
        accordionCheckboxSlotSize: 40,
        accordionAnimationDuration: const Duration(milliseconds: 200),
        resistanceGap: 5,
        nameFieldFillColor: Colors.white,
      ),
      DenpaMenLabelThemeData(
        headerTitleOutlineColor: const Color(0xFF238BCB),
        pillBackgroundColor: const Color(0xFF7FC9FF),
        pillTextColor: const Color(0xFF2B2031),
        expBarFilledColor: const Color(0xFFFFEB3B),
        expBarUnfilledColor: const Color(0xFF056193),
        maxedValueColor: const Color(0xFF7BEA95),
        inactiveBonusColor: const Color(0xFFE53935),
        titleFillColor: Colors.white,
        expBarBorderColor: palette.expBarBorderColor,
      ),
      SplashThemeData(
        backgroundColor: palette.splashBackgroundColor,
        appNameFontSize: 34,
        fadeOutDuration: const Duration(milliseconds: 400),
      ),
      PhysiqueLegendGridThemeData(
        highlightBorderColor: palette.legendGridHighlightBorderColor,
        dimmedBackgroundColor: palette.legendGridDimmedBackgroundColor,
      ),
      buttonTheme,
      ToggleButtonGroupThemeData(
        containerColor: colorScheme.surface,
        containerElevation: 4,
        containerBorderRadius: 22,
        highlightColor: const Color(0xFF7FC9FF),
        highlightBorderRadius: 20,
        selectedIconColor: const Color(0xFF056193),
        unselectedIconColor: colorScheme.onSurfaceVariant,
        slideDuration: const Duration(milliseconds: 220),
        slideCurve: Curves.easeOutBack,
      ),
      ListItemContainerThemeData(
        backgroundColor: settingsContainerColor,
        borderRadius: 20,
        tileBorderColor: colorScheme.outlineVariant,
        tileBorderWidth: 1,
        selectedBackgroundColor: listItemSelectedColor,
        checkAnimationDuration: const Duration(milliseconds: 200),
        checkAnimationInCurve: Curves.easeOut,
        checkAnimationOutCurve: Curves.easeIn,
      ),
      NavigationBarBlurThemeData(
        tintColor: palette.navigationBarTintColor,
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
}

ButtonStyle _frostedButtonStyle(AppButtonThemeData theme) {
  return ButtonStyle(
    shape: const WidgetStatePropertyAll(StadiumBorder()),
    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    foregroundColor: WidgetStatePropertyAll(theme.foregroundColor),
    backgroundBuilder: (context, states, child) => FrostedBlur(
      sigma: theme.blurSigma,
      tintColor: theme.backgroundTintColor,
      borderRadius: BorderRadius.circular(999),
      child: child ?? const SizedBox.shrink(),
    ),
  );
}

/// The app's main accent blue (also [SlantedHeaderThemeData.fillColor]),
/// carried at a lightness [delta] away from [scheme]'s own surface color
/// (see [_AppPalette.settingsContainerLightnessDelta]). Shared by
/// [ListItemContainerThemeData.backgroundColor] and
/// [DenpaMenContainerThemeData.nestedBackgroundColor] so the two box
/// styles read as the same design language. Built from this fixed hue
/// rather than [scheme.surface] itself, since `ColorScheme.fromSeed`'s
/// "neutral" surface colors already carry a tint of the deepPurple seed.
Color _settingsContainerColor(ColorScheme scheme, double delta) {
  final backgroundLightness = HSLColor.fromColor(scheme.surface).lightness;
  final mainColorHsl = HSLColor.fromColor(const Color(0xFF52BBE5));
  return mainColorHsl
      .withLightness((backgroundLightness + delta).clamp(0.0, 1.0).toDouble())
      .toColor();
}

/// [base], with its HSL lightness shifted by [amount] (-1 to 1, negative
/// darkens), clamped to a valid lightness. Used for the selected-row tint
/// (see [_AppPalette.selectedItemLightnessDelta]) and
/// [DialogThemeData.backgroundColor] (a paler tint of
/// [ListItemContainerThemeData.backgroundColor]).
Color _lightnessShifted(Color base, double amount) {
  final hsl = HSLColor.fromColor(base);
  return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
}
