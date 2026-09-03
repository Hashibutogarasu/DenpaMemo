import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';

/// The app's light/dark [ThemeData], including every `denpamemo_widgets`
/// [ThemeExtension] and the standard Flutter theme fields those widgets
/// don't cover on their own.
abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    elevatedButtonTheme: _elevatedButtonTheme,
    listTileTheme: _listTileTheme,
    extensions: const [
      SlantedHeaderThemeData(
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
      ),
      DenpaMenLabelThemeData(
        headerTitleOutlineColor: Color(0xFF238BCB),
        pillBackgroundColor: Color(0xFF7FC9FF),
        pillTextColor: Color(0xFF2B2031),
        expBarFilledColor: Color(0xFFFFEB3B),
        expBarUnfilledColor: Color(0xFF056193),
        maxedValueColor: Color(0xFF7BEA95),
        inactiveBonusColor: Color(0xFFE53935),
      ),
    ],
  );

  static final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    elevatedButtonTheme: _elevatedButtonTheme,
    listTileTheme: _listTileTheme,
    extensions: const [
      SlantedHeaderThemeData(
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
      ),
      DenpaMenLabelThemeData(
        headerTitleOutlineColor: Color(0xFF238BCB),
        pillBackgroundColor: Color(0xFF7FC9FF),
        pillTextColor: Color(0xFF2B2031),
        expBarFilledColor: Color(0xFFFFEB3B),
        expBarUnfilledColor: Color(0xFF056193),
        maxedValueColor: Color(0xFF7BEA95),
        inactiveBonusColor: Color(0xFFE53935),
      ),
    ],
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          minimumSize: const Size(64, AppBackButton.height),
        ),
      );

  static const ListTileThemeData _listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
  );
}
