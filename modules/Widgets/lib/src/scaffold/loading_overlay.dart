import 'package:flutter/material.dart';

import '../theme/fab_button_theme.dart';

/// Dims [child] and shows a centered spinner on top of it while [loading],
/// instead of swapping [child] out entirely — so a page's shell (header,
/// buttons) stays mounted, and whatever [child] renders once [loading]
/// turns false appears fully formed rather than mid-build. Uses
/// [FabButtonThemeData.barrierColor], the same themed scrim color other
/// dimming overlays in this app use.
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key, required this.loading, required this.child});

  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        if (loading)
          Positioned.fill(
            child: IgnorePointer(
              child: ColoredBox(
                color: Theme.of(context).extension<FabButtonThemeData>()!.barrierColor,
                child: const Center(child: RepaintBoundary(child: CircularProgressIndicator())),
              ),
            ),
          ),
      ],
    );
  }
}
