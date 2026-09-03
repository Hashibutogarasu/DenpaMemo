import 'package:flutter/material.dart';

import '../theme/fab_button_theme.dart';

/// One labeled small [FloatingActionButton] in a stack of options revealed
/// above a main FAB, sliding/fading in or out as [open] toggles. Animation
/// curve/offset and label-bubble styling come from [FabButtonThemeData];
/// [animationDuration] defaults to the theme's value but can be overridden
/// per instance.
class MiniFabOption extends StatelessWidget {
  const MiniFabOption({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.open,
    this.animationDuration,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool open;
  final Duration? animationDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<FabButtonThemeData>()!;
    final duration = animationDuration ?? theme.mainButtonAnimationDuration;
    return IgnorePointer(
      ignoring: !open,
      child: AnimatedSlide(
        duration: duration,
        curve: theme.miniOptionSlideCurve,
        offset: open ? Offset.zero : theme.miniOptionSlideOffset,
        child: AnimatedOpacity(
          duration: duration,
          curve: theme.miniOptionSlideCurve,
          opacity: open ? 1 : 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: theme.miniOptionRowBottomPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: theme.labelBubbleElevation,
                  borderRadius: BorderRadius.circular(
                    theme.labelBubbleBorderRadius,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      theme.labelBubbleBorderRadius,
                    ),
                    onTap: onPressed,
                    child: Padding(
                      padding: theme.labelBubblePadding,
                      child: Text(label),
                    ),
                  ),
                ),
                SizedBox(width: theme.miniOptionGap),
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
