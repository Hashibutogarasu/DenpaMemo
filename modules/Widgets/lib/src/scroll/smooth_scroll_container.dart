import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:silky_scroll/silky_scroll.dart';

/// Wraps `silky_scroll`'s [SilkyScroll] with this app's default feel.
/// [child]'s descendant scrollables pick up the managed
/// [ScrollController]/[ScrollPhysics] automatically (via
/// [PrimaryScrollController]/[ScrollConfiguration]) as long as they don't
/// set their own `controller`; [SmoothScrollContainer.builder] bypasses
/// that and exposes [SilkyScroll]'s raw builder for callers that need to
/// wire a scrollable themselves.
class SmoothScrollContainer extends StatelessWidget {
  const SmoothScrollContainer({
    super.key,
    required Widget child,
    this.scrollDirection = Axis.vertical,
  }) : _child = child,
       builder = null;

  const SmoothScrollContainer.builder({
    super.key,
    required SilkyScrollWidgetBuilder this.builder,
    this.scrollDirection = Axis.vertical,
  }) : _child = null;

  final Widget? _child;
  final SilkyScrollWidgetBuilder? builder;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return SilkyScroll(
      direction: scrollDirection,
      physics: const BouncingScrollPhysics(),
      silkyScrollDuration: const Duration(milliseconds: 1000),
      scrollSpeed: 1.5,
      animationCurve: Curves.easeOutQuart,
      builder: builder ?? _wrapChild,
    );
  }

  Widget _wrapChild(
    BuildContext context,
    ScrollController controller,
    ScrollPhysics physics,
    PointerDeviceKind? pointerDeviceKind,
  ) {
    return PrimaryScrollController(
      controller: controller,
      child: ScrollConfiguration(
        behavior: _SmoothScrollBehavior(physics),
        child: _child!,
      ),
    );
  }
}

class _SmoothScrollBehavior extends ScrollBehavior {
  const _SmoothScrollBehavior(this.physics);

  final ScrollPhysics physics;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => physics;
}
