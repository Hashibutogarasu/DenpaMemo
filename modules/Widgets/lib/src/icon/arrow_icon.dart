import 'package:flutter/material.dart';

import 'package:flutter_lucide_animated/flutter_lucide_animated.dart' as lucide;

/// Which endpoint an [ArrowIcon] points data toward: [toCloud] for a
/// backup upload, [toLocal] for a restore download.
enum ArrowDirection { toCloud, toLocal }

/// A single bounce-looping arrow that flips between pointing at the cloud
/// and pointing at the device, used to indicate the direction data is
/// moving during a cloud backup/restore operation.
///
/// Direction is expressed as a 180-degree rotation of one base icon rather
/// than swapping between two separate icons, so the bounce animation stays
/// visually continuous across a direction change: since the rotation wraps
/// the bounce, a bounce toward the icon's own "up" reads as a bounce
/// downward once the whole thing is flipped for [ArrowDirection.toLocal].
///
/// [lucide.arrow_up]'s own baked-in animation only draws its stroke, so the
/// bounce itself is driven by a plain [AnimationController] here rather
/// than [lucide.AnimationTrigger.loop].
class ArrowIcon extends StatefulWidget {
  const ArrowIcon({
    super.key,
    this.direction = ArrowDirection.toCloud,
    this.isAnimating = false,
    this.size = 32,
    this.color,
  });

  final ArrowDirection direction;
  final bool isAnimating;
  final double size;

  /// Falls back to the ambient [IconTheme], then the theme's
  /// `colorScheme.onSurface`, since [lucide.LucideAnimatedIcon] does not
  /// pick up [IconTheme] on its own the way [Icon] does.
  final Color? color;

  @override
  State<ArrowIcon> createState() => _ArrowIconState();
}

class _ArrowIconState extends State<ArrowIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<double> _bounce = CurvedAnimation(
    parent: _bounceController,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    super.initState();
    _syncBounce();
  }

  @override
  void didUpdateWidget(ArrowIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isAnimating != widget.isAnimating) {
      _syncBounce();
    }
  }

  void _syncBounce() {
    if (widget.isAnimating) {
      _bounceController.repeat(reverse: true);
    } else {
      _bounceController.stop();
      _bounceController.value = 0;
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        widget.color ??
        IconTheme.of(context).color ??
        Theme.of(context).colorScheme.onSurface;
    return AnimatedRotation(
      turns: widget.direction == ArrowDirection.toCloud ? 0.0 : 0.5,
      duration: const Duration(milliseconds: 300),
      child: AnimatedBuilder(
        animation: _bounce,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, -_bounce.value * widget.size * 0.25),
          child: child,
        ),
        child: lucide.LucideAnimatedIcon(
          icon: lucide.arrow_up,
          size: widget.size,
          color: effectiveColor,
        ),
      ),
    );
  }
}
