import 'package:flutter/material.dart';

import 'theme/splash_theme.dart';

/// Horizontal lockup pairing a brand icon with the app name, sized from
/// [SplashThemeData.appNameFontSize]. Presentation-only: callers supply the
/// icon widget and app name text, so this stays independent of any
/// specific translation setup and is previewable in Widgetbook on its own.
class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key, required this.icon, required this.appName});

  final Widget icon;
  final String appName;

  static const double _iconSizeFactor = 1.3;
  static const double _gap = 12;

  @override
  Widget build(BuildContext context) {
    final splashTheme = Theme.of(context).extension<SplashThemeData>()!;
    final iconSize = splashTheme.appNameFontSize * _iconSizeFactor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: iconSize, height: iconSize, child: icon),
        SizedBox(width: _gap),
        Text(
          appName,
          style: TextStyle(
            fontSize: splashTheme.appNameFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
