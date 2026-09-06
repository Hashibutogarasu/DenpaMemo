import 'package:flutter/material.dart';

import '../theme/toggle_button_group_theme.dart';

/// Rounded, elevated group of icon toggle buttons backing a value of type
/// [T] (e.g. a view-mode enum). Layout-agnostic — the caller positions it
/// (typically via [Positioned]) and supplies one labeled icon per [values]
/// entry via [children]. The selection highlight slides between segments
/// instead of swapping instantly.
class ToggleButtonGroup<T> extends StatelessWidget {
  const ToggleButtonGroup({
    super.key,
    required this.values,
    required this.selected,
    required this.onChanged,
    required this.children,
  });

  final List<T> values;
  final T selected;
  final ValueChanged<T> onChanged;
  final List<Widget> children;

  static const _segmentSize = 44.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ToggleButtonGroupThemeData>()!;
    final selectedIndex = values.indexOf(selected);

    return Material(
      color: theme.containerColor,
      elevation: theme.containerElevation,
      borderRadius: BorderRadius.circular(theme.containerBorderRadius),
      child: SizedBox(
        width: _segmentSize * values.length,
        height: _segmentSize,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: theme.slideDuration,
              curve: theme.slideCurve,
              left: _segmentSize * selectedIndex,
              width: _segmentSize,
              top: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.highlightColor,
                    borderRadius: BorderRadius.circular(
                      theme.highlightBorderRadius,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final (index, value) in values.indexed)
                  SizedBox(
                    width: _segmentSize,
                    height: _segmentSize,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        theme.containerBorderRadius,
                      ),
                      onTap: () => onChanged(value),
                      child: IconTheme(
                        data: IconThemeData(
                          color: index == selectedIndex
                              ? theme.selectedIconColor
                              : theme.unselectedIconColor,
                        ),
                        child: Center(child: children[index]),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
