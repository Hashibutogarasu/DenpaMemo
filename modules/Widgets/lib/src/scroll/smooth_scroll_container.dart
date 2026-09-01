import 'package:flutter/material.dart';
import 'package:silky_scroll/silky_scroll.dart';

/// Makes every `ListView`/`GridView`/`SingleChildScrollView`/
/// `CustomScrollView` under [child] scroll via `silky_scroll`, with no
/// per-widget wiring: [PrimaryScrollController] hands them the managed
/// [ScrollController] (as long as they don't set their own explicit
/// `controller`), and [ScrollConfiguration] hands them the managed
/// [ScrollPhysics]. `SilkyScroll`'s own [Listener] wraps [child] as a
/// whole, so pointer events from any descendant scrollable reach it too.
class SmoothScrollContainer extends StatelessWidget {
  const SmoothScrollContainer({
    super.key,
    required this.child,
    this.scrollDirection = Axis.vertical,
  });

  final Widget child;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return SilkyScroll(
      direction: scrollDirection,
      builder: (context, controller, physics, pointerDeviceKind) {
        return PrimaryScrollController(
          controller: controller,
          child: ScrollConfiguration(
            behavior: _SmoothScrollBehavior(physics),
            child: child,
          ),
        );
      },
    );
  }
}

class _SmoothScrollBehavior extends ScrollBehavior {
  const _SmoothScrollBehavior(this.physics);

  final ScrollPhysics physics;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => physics;
}
