import 'package:flutter/material.dart';

import 'package:silky_scroll/silky_scroll.dart';

/// Wraps `silky_scroll`'s [SilkyScroll] with this app's default feel.
/// Descendant scrollables pick up the managed [ScrollController]
/// automatically unless [controller] is given, in which case the caller
/// owns its lifecycle instead of [SilkyScroll]. [child] (or a [builder]
/// result) must always be an actual scrollable — use [ScrollableFiller] for
/// states with nothing to scroll, since `silky_scroll` reads the controller
/// from pointer handlers regardless of attachment.
class SmoothScrollContainer extends StatelessWidget {
  const SmoothScrollContainer({
    super.key,
    required Widget child,
    this.scrollDirection = Axis.vertical,
    this.controller,
  }) : _child = child,
       builder = null;

  const SmoothScrollContainer.builder({
    super.key,
    required SilkyScrollWidgetBuilder this.builder,
    this.scrollDirection = Axis.vertical,
  }) : _child = null,
       controller = null;

  final Widget? _child;
  final SilkyScrollWidgetBuilder? builder;
  final Axis scrollDirection;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return SilkyScroll(
      direction: scrollDirection,
      physics: const BouncingScrollPhysics(),
      silkyScrollDuration: const Duration(milliseconds: 1000),
      scrollSpeed: 1.5,
      animationCurve: Curves.easeOutQuart,
      controller: controller,
      builder: builder ?? _wrapChild,
    );
  }

  Widget _wrapChild(
    BuildContext context,
    ScrollController controller,
    ScrollPhysics physics,
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

/// Fills the viewport with [child] via a scrollable that still attaches to
/// the ambient [PrimaryScrollController] even though [child] itself has
/// nothing to scroll. Use for a [SmoothScrollContainer]'s loading/error/empty
/// states so its shared controller never goes unattached.
class ScrollableFiller extends StatelessWidget {
  const ScrollableFiller({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: child,
        ),
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
