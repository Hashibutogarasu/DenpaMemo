import 'package:flutter/material.dart';

import '../effect/frosted_blur.dart';
import 'app_button_theme.dart';
import 'app_constants.dart';
import 'back_button_theme.dart';
import 'denpa_men_container_theme.dart';
import 'denpa_men_label_theme.dart';
import 'dialog_transition_theme.dart';
import 'fab_button_theme.dart';
import 'fab_label_theme.dart';
import 'list_item_container_theme.dart';
import 'navigation_bar_blur_theme.dart';
import 'physique_legend_grid_theme.dart';
import 'slanted_header_theme.dart';
import 'splash_theme.dart';
import 'toggle_button_group_theme.dart';

/// [ThemeData] fields shared by every brightness/contrast variant this app
/// builds, kept apart from [AppPalette] since neither differs between them.
abstract final class AppCommonTheme {
  static const ListTileThemeData listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppConstants.radiusMd)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
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

/// Every value [buildAppTheme] needs that isn't derivable from
/// [ColorScheme.fromSeed] alone, and instead differs by hand between light
/// and dark. The app supplies one constant instance per brightness, so
/// [buildAppTheme] never branches on brightness itself — it only ever reads
/// `palette.someField`.
class AppPalette {
  const AppPalette({
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

/// Builds the app's [ThemeData] for a given [brightness] and [palette], at
/// the given Material 3 [contrastLevel] (`-1.0`..`1.0`; the app exposes
/// `0.0`/standard, `0.5`/medium and `1.0`/high to the user).
ThemeData buildAppTheme(
  Brightness brightness,
  AppPalette palette, {
  double contrastLevel = 0.0,
}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: brightness,
    contrastLevel: contrastLevel,
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
  final disabledForegroundColor = colorScheme.onSurface.withValues(alpha: 0.38);
  final disabledColor = colorScheme.onSurface.withValues(alpha: 0.12);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    textTheme: _textTheme(colorScheme),
    listTileTheme: AppCommonTheme.listTileTheme,
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppConstants.radiusXl),
        ),
        side: BorderSide(color: listItemSelectedColor, width: 5),
      ),
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: _lightnessShifted(settingsContainerColor, 0.05),
    ),
    navigationBarTheme: AppCommonTheme.navigationBarTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: AppConstants.elevationLevel0,
    ),
    cardTheme: CardThemeData(
      color: settingsContainerColor,
      elevation: AppConstants.elevationLevel1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: settingsContainerColor,
      selectedColor: listItemSelectedColor,
      labelStyle: TextStyle(color: colorScheme.onSurface),
      shape: const StadiumBorder(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: AppConstants.borderWidthMedium,
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabledForegroundColor;
          }
          return colorScheme.onSurfaceVariant;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: disabledColor);
          }
          return BorderSide(color: colorScheme.primary);
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabledForegroundColor;
          }
          return colorScheme.primary;
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabledForegroundColor;
          }
          return colorScheme.primary;
        }),
      ),
    ),
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
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.primary,
      linearTrackColor: settingsContainerColor,
      circularTrackColor: settingsContainerColor,
    ),
    dividerTheme: DividerThemeData(
      color: colorScheme.outlineVariant,
      thickness: AppConstants.borderWidthThin,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      elevation: AppConstants.elevationLevel0,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      indicatorColor: colorScheme.primary,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return disabledColor;
        if (states.contains(WidgetState.selected)) return colorScheme.primary;
        return colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor;
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withValues(alpha: 0.5);
        }
        return colorScheme.surfaceContainerHighest;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return disabledColor;
        if (states.contains(WidgetState.selected)) return colorScheme.primary;
        return Colors.transparent;
      }),
      checkColor: const WidgetStatePropertyAll(Colors.white),
      side: BorderSide(color: colorScheme.outline),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return disabledColor;
        if (states.contains(WidgetState.selected)) return colorScheme.primary;
        return colorScheme.outline;
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: colorScheme.surfaceContainerHighest,
      thumbColor: colorScheme.primary,
      overlayColor: colorScheme.primary.withValues(alpha: 0.12),
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

/// The Material 3 type scale (`displayLarge`..`labelSmall`), sized from
/// [AppConstants]'s font-size tokens and colored from [scheme.onSurface] so
/// text keeps legible contrast across every brightness/contrast variant.
TextTheme _textTheme(ColorScheme scheme) {
  final color = scheme.onSurface;
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: AppConstants.fontSizeDisplayLarge,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 64 / AppConstants.fontSizeDisplayLarge,
      color: color,
    ),
    displayMedium: TextStyle(
      fontSize: AppConstants.fontSizeDisplayMedium,
      fontWeight: FontWeight.w400,
      height: 52 / AppConstants.fontSizeDisplayMedium,
      color: color,
    ),
    displaySmall: TextStyle(
      fontSize: AppConstants.fontSizeDisplaySmall,
      fontWeight: FontWeight.w400,
      height: 44 / AppConstants.fontSizeDisplaySmall,
      color: color,
    ),
    headlineLarge: TextStyle(
      fontSize: AppConstants.fontSizeHeadlineLarge,
      fontWeight: FontWeight.w400,
      height: 40 / AppConstants.fontSizeHeadlineLarge,
      color: color,
    ),
    headlineMedium: TextStyle(
      fontSize: AppConstants.fontSizeHeadlineMedium,
      fontWeight: FontWeight.w400,
      height: 36 / AppConstants.fontSizeHeadlineMedium,
      color: color,
    ),
    headlineSmall: TextStyle(
      fontSize: AppConstants.fontSizeHeadlineSmall,
      fontWeight: FontWeight.w400,
      height: 32 / AppConstants.fontSizeHeadlineSmall,
      color: color,
    ),
    titleLarge: TextStyle(
      fontSize: AppConstants.fontSizeTitleLarge,
      fontWeight: FontWeight.w500,
      height: 28 / AppConstants.fontSizeTitleLarge,
      color: color,
    ),
    titleMedium: TextStyle(
      fontSize: AppConstants.fontSizeTitleMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 24 / AppConstants.fontSizeTitleMedium,
      color: color,
    ),
    titleSmall: TextStyle(
      fontSize: AppConstants.fontSizeTitleSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 20 / AppConstants.fontSizeTitleSmall,
      color: color,
    ),
    bodyLarge: TextStyle(
      fontSize: AppConstants.fontSizeBodyLarge,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 24 / AppConstants.fontSizeBodyLarge,
      color: color,
    ),
    bodyMedium: TextStyle(
      fontSize: AppConstants.fontSizeBodyMedium,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 20 / AppConstants.fontSizeBodyMedium,
      color: color,
    ),
    bodySmall: TextStyle(
      fontSize: AppConstants.fontSizeBodySmall,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 16 / AppConstants.fontSizeBodySmall,
      color: color,
    ),
    labelLarge: TextStyle(
      fontSize: AppConstants.fontSizeLabelLarge,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 20 / AppConstants.fontSizeLabelLarge,
      color: color,
    ),
    labelMedium: TextStyle(
      fontSize: AppConstants.fontSizeLabelMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 16 / AppConstants.fontSizeLabelMedium,
      color: color,
    ),
    labelSmall: TextStyle(
      fontSize: AppConstants.fontSizeLabelSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 16 / AppConstants.fontSizeLabelSmall,
      color: color,
    ),
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
/// (see [AppPalette.settingsContainerLightnessDelta]). Shared by
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
/// (see [AppPalette.selectedItemLightnessDelta]) and
/// [DialogThemeData.backgroundColor] (a paler tint of
/// [ListItemContainerThemeData.backgroundColor]).
Color _lightnessShifted(Color base, double amount) {
  final hsl = HSLColor.fromColor(base);
  return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
}
