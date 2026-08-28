import 'package:flutter/material.dart';

/// One labeled small [FloatingActionButton] in a stack of options revealed
/// above a main FAB, sliding/fading in or out as [open] toggles.
class MiniFabOption extends StatelessWidget {
  const MiniFabOption({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.open,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool open;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !open,
      child: AnimatedSlide(
        duration: animationDuration,
        curve: Curves.easeOutCubic,
        offset: open ? Offset.zero : const Offset(0, 0.3),
        child: AnimatedOpacity(
          duration: animationDuration,
          curve: Curves.easeOutCubic,
          opacity: open ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(label),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton.small(
                  heroTag: null,
                  onPressed: onPressed,
                  child: Icon(icon),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
