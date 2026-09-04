import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';

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
  );
}

abstract final class AppLightTheme {
  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    listTileTheme: AppCommonTheme.listTileTheme,
    dialogTheme: AppCommonTheme.dialogTheme,
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
      AppDialogThemeData(
        transitionDuration: Duration(milliseconds: 320),
        transitionCurve: Curves.easeOutCubic,
        reverseTransitionCurve: Curves.easeInCubic,
        barrierColor: Colors.black54,
      ),
      SplashThemeData(
        backgroundColor: Color(0xFFF3EDF7),
        appNameFontSize: 34,
        displayDuration: Duration(seconds: 1),
        fadeOutDuration: Duration(milliseconds: 400),
      ),
    ],
  );
}

abstract final class AppDarkTheme {
  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    listTileTheme: AppCommonTheme.listTileTheme,
    dialogTheme: AppCommonTheme.dialogTheme,
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
      AppDialogThemeData(
        transitionDuration: Duration(milliseconds: 320),
        transitionCurve: Curves.easeOutCubic,
        reverseTransitionCurve: Curves.easeInCubic,
        barrierColor: Colors.black54,
      ),
      SplashThemeData(
        backgroundColor: Color(0xFF1D1B20),
        appNameFontSize: 34,
        displayDuration: Duration(seconds: 1),
        fadeOutDuration: Duration(milliseconds: 400),
      ),
    ],
  );
}
