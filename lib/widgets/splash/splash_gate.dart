import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart';

import 'splash_screen.dart';

/// Wraps `MaterialApp.router`'s built content, showing [SplashScreen] until
/// [ready] turns true, then fading it out over
/// [SplashThemeData.fadeOutDuration] to reveal [child]. A no-op on
/// Android, where `SplashActivity` shows a native equivalent instead.
class SplashGate extends StatefulWidget {
  const SplashGate({super.key, required this.child, required this.ready});

  final Widget child;
  final bool ready;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  bool _fadingOut = false;
  bool _splashVisible = defaultTargetPlatform != TargetPlatform.android;

  @override
  void initState() {
    super.initState();
    _fadingOut = widget.ready;
  }

  @override
  void didUpdateWidget(covariant SplashGate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.ready && !oldWidget.ready) {
      setState(() => _fadingOut = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_splashVisible) return widget.child;
    final splashTheme = Theme.of(context).extension<SplashThemeData>()!;

    return Stack(
      children: [
        widget.child,
        AnimatedOpacity(
          opacity: _fadingOut ? 0 : 1,
          duration: splashTheme.fadeOutDuration,
          onEnd: _fadingOut
              ? () => setState(() => _splashVisible = false)
              : null,
          child: const SplashScreen(),
        ),
      ],
    );
  }
}
