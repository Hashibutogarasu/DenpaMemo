import 'package:flutter/material.dart';

import 'package:denpa_memo/widgets.dart';
import '../../i18n/gen/strings.g.dart';

/// Full-screen splash shown at startup by [SplashGate] until it's told the
/// main screen is ready. Purely presentational: it never reads any
/// initialization provider itself.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashTheme = Theme.of(context).extension<SplashThemeData>()!;

    return Scaffold(
      backgroundColor: splashTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LogoContainer(
              icon: Image.asset(
                'assets/icons/app_icon.png',
                fit: BoxFit.contain,
              ),
              appName: context.t.app.name,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
