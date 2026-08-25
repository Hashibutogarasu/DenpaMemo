import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// Wraps [child] with a middle-mouse-button click listener, calling
/// [onMiddleClick] on press. Purely additive — it never claims taps, drags,
/// or any other gesture, so it can be layered over any existing
/// `GestureDetector`/`InkWell` without interfering with it.
class MiddleClickDetector extends StatelessWidget {
  const MiddleClickDetector({super.key, required this.child, this.onMiddleClick});

  final Widget child;
  final VoidCallback? onMiddleClick;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (event.buttons & kMiddleMouseButton != 0) {
          onMiddleClick?.call();
        }
      },
      child: child,
    );
  }
}
