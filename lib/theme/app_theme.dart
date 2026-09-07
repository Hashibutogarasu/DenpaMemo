import 'package:flutter/material.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart';

abstract final class AppCommonTheme {
  static const ListTileThemeData listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
  );

  static const DialogThemeData dialogTheme = DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    insetPadding: EdgeInsets.all(20),
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

abstract final class AppLightTheme {
  static final ThemeData theme = _buildTheme(Brightness.light);
}

abstract final class AppDarkTheme {
  static final ThemeData theme = _buildTheme(Brightness.dark);
}

ThemeData _buildTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: brightness,
  );
  final buttonTheme = AppButtonThemeData(
    backgroundTintColor: const Color(0x995B7FA6),
    blurSigma: 12,
    foregroundColor: Colors.white,
  );
  final settingsContainerColor = _settingsContainerColor(colorScheme);

  return ThemeData(
    colorScheme: colorScheme,
    listTileTheme: AppCommonTheme.listTileTheme,
    dialogTheme: AppCommonTheme.dialogTheme,
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
        statusBackgroundColor: const Color(0xFF90E2FF),
        statusBorderRadius: 20,
        nestedBackgroundColor: settingsContainerColor,
        nestedBorderColor: const Color(0xFF90DAFE),
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
        expBarBorderColor: isDark ? Colors.white70 : Colors.black,
      ),
      SplashThemeData(
        backgroundColor: isDark
            ? const Color(0xFF1D1B20)
            : const Color(0xFFF3EDF7),
        appNameFontSize: 34,
        displayDuration: const Duration(seconds: 1),
        fadeOutDuration: const Duration(milliseconds: 400),
      ),
      PhysiqueLegendGridThemeData(
        highlightBorderColor: isDark
            ? const Color(0xFFEF5350)
            : const Color(0xFFE53935),
        dimmedBackgroundColor: isDark
            ? const Color(0x1FFFFFFF)
            : const Color(0x14000000),
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
        slideDuration: const Duration(milliseconds: 200),
        slideCurve: Curves.easeOutCubic,
      ),
      ListItemContainerThemeData(
        backgroundColor: settingsContainerColor,
        borderRadius: 20,
        tileBorderColor: colorScheme.outlineVariant,
        tileBorderWidth: 1,
      ),
      NavigationBarBlurThemeData(
        tintColor: isDark
            ? Colors.black.withValues(alpha: 0.5)
            : Colors.white.withValues(alpha: 0.5),
        blurSigma: 12,
      ),
      const BackButtonThemeData(anchor: BackButtonAnchor.bottomLeft),
      const FabLabelThemeData(showLabel: false, showTooltip: true),
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
/// carried at a lightness 5% below [scheme]'s own surface color. Shared by
/// [ListItemContainerThemeData.backgroundColor] and
/// [DenpaMenContainerThemeData.nestedBackgroundColor] so the two box
/// styles read as the same design language. Built from this fixed hue
/// rather than [scheme.surface] itself, since `ColorScheme.fromSeed`'s
/// "neutral" surface colors already carry a tint of the deepPurple seed.
Color _settingsContainerColor(ColorScheme scheme) {
  final backgroundLightness = HSLColor.fromColor(scheme.surface).lightness;
  final mainColorHsl = HSLColor.fromColor(const Color(0xFF52BBE5));
  return mainColorHsl
      .withLightness((backgroundLightness - 0.05).clamp(0.0, 1.0).toDouble())
      .toColor();
}
