import 'package:flutter/material.dart';

import 'package:silky_scroll/silky_scroll.dart';

/// A [ScrollController] that tolerates being read while unattached instead
/// of asserting. `silky_scroll` (which backs [SmoothScrollContainer]) reads
/// its shared controller's [offset]/[position] and calls [animateTo]/
/// [jumpTo] directly from its own pointer handlers, regardless of whether a
/// scrollable is currently attached — e.g. while the content is a
/// non-scrollable loading/empty/error widget, or momentarily between one
/// scrollable being swapped for another. A plain [ScrollController] asserts
/// in that situation ("ScrollController not attached to any scroll views").
///
/// [SmoothScrollContainer] wires [fallback] to a tiny scrollable it keeps
/// permanently mounted for exactly this purpose, so [position]/[offset] stay
/// safely readable — falling back to that always-attached, zero-size
/// scrollable's own position — even before this controller's real content
/// has ever attached one of its own.
class SafeScrollController extends ScrollController {
  SafeScrollController({super.initialScrollOffset, super.debugLabel});

  ScrollController? fallback;

  bool get _fallbackHasClients => fallback?.hasClients ?? false;

  @override
  ScrollPosition get position => hasClients
      ? super.position
      : (_fallbackHasClients ? fallback!.position : super.position);

  @override
  double get offset => hasClients
      ? super.offset
      : (_fallbackHasClients ? fallback!.offset : 0.0);

  @override
  Future<void> animateTo(
    double offset, {
    required Duration duration,
    required Curve curve,
  }) {
    return hasClients
        ? super.animateTo(offset, duration: duration, curve: curve)
        : Future<void>.value();
  }

  @override
  void jumpTo(double value) {
    if (hasClients) super.jumpTo(value);
  }
}

/// Wraps `silky_scroll`'s [SilkyScroll] with this app's default feel.
/// Descendant scrollables pick up the managed [ScrollController]
/// automatically unless [controller] is given, in which case the caller
/// owns its lifecycle instead of [SilkyScroll]. Always backed by a
/// [SafeScrollController] (its own when [controller] is omitted, or the
/// caller's if it already is one) so `child` never has to be an always-on
/// scrollable itself to avoid crashing.
class SmoothScrollContainer extends StatefulWidget {
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

  /// Typed as [SafeScrollController] (rather than plain [ScrollController])
  /// so a caller that owns the controller can't reintroduce the crash this
  /// class exists to prevent.
  final SafeScrollController? controller;

  @override
  State<SmoothScrollContainer> createState() => _SmoothScrollContainerState();
}

class _SmoothScrollContainerState extends State<SmoothScrollContainer> {
  final ScrollController _fallbackController = ScrollController();
  SafeScrollController? _ownController;

  SafeScrollController get _effectiveController {
    final controller =
        widget.controller ?? (_ownController ??= SafeScrollController());
    controller.fallback = _fallbackController;
    return controller;
  }

  @override
  void dispose() {
    _ownController?.dispose();
    _fallbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SilkyScroll(
          direction: widget.scrollDirection,
          physics: const BouncingScrollPhysics(),
          silkyScrollDuration: const Duration(milliseconds: 1000),
          scrollSpeed: 1.5,
          animationCurve: Curves.easeOutQuart,
          controller: _effectiveController,
          builder: widget.builder ?? _wrapChild,
        ),
        Positioned(
          left: 0,
          top: 0,
          width: 0,
          height: 0,
          child: SingleChildScrollView(controller: _fallbackController),
        ),
      ],
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
        child: widget._child!,
      ),
    );
  }
}

/// Fills the viewport with [child] via a scrollable that still attaches to
/// the ambient [PrimaryScrollController] even though [child] itself has
/// nothing to scroll. Use for a [SmoothScrollContainer]'s loading/error/empty
/// states so a gesture like pull-to-refresh keeps working over them.
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
