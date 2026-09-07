import 'dart:async';

import 'package:flutter/material.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart';

import 'splash_screen.dart';

/// Wraps `MaterialApp.router`'s built content, showing [SplashScreen] for
/// [SplashThemeData.displayDuration] before fading it out over
/// [SplashThemeData.fadeOutDuration] to reveal [child]. Purely time-based:
/// unrelated to whatever startup data providers are still resolving.
class SplashGate extends StatefulWidget {
  const SplashGate({super.key, required this.child});

  final Widget child;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  bool _timerStarted = false;
  bool _fadingOut = false;
  bool _splashVisible = true;
  Timer? _displayTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_timerStarted) return;
    _timerStarted = true;
    final splashTheme = Theme.of(context).extension<SplashThemeData>()!;
    _displayTimer = Timer(splashTheme.displayDuration, () {
      if (!mounted) return;
      setState(() => _fadingOut = true);
    });
  }

  @override
  void dispose() {
    _displayTimer?.cancel();
    super.dispose();
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
