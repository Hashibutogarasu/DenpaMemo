import 'package:flutter/material.dart';

import '../theme/list_item_container_theme.dart';

/// [list.indexWhere(test)], normalized to `null` instead of -1 when
/// nothing matches — the "nothing selected" value
/// [ListItemContainer.selectedIndex] expects.
int? indexOfOrNull<T>(List<T> list, bool Function(T element) test) {
  final index = list.indexWhere(test);
  return index == -1 ? null : index;
}

/// Wraps a list of items (typically [ListItemTile]s) with a themed,
/// rounded-corner container — no outer margin of its own; the caller
/// decides spacing. A thin divider is drawn between adjacent items only,
/// not above the first or below the last.
///
/// Passing [selectedIndex] (for a "pick one of these" list, all rows the
/// same [itemHeight]) draws one shared highlight+check layer that glides
/// from the old selected row to the new one, crossing row boundaries as a
/// single continuous slide instead of each row animating on its own.
class ListItemContainer extends StatelessWidget {
  const ListItemContainer({
    super.key,
    required this.children,
    this.selectedIndex,
    this.itemHeight = 56,
  });

  final List<Widget> children;
  final int? selectedIndex;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ListItemContainerThemeData>()!;
    final selectedIndex = this.selectedIndex;
    return ClipRRect(
      borderRadius: BorderRadius.circular(theme.borderRadius),
      child: ColoredBox(
        color: theme.backgroundColor,
        child: Stack(
          children: [
            if (selectedIndex != null)
              AnimatedPositioned(
                duration: theme.checkAnimationDuration,
                curve: theme.checkAnimationInCurve,
                top: selectedIndex * itemHeight,
                left: 0,
                right: 0,
                height: itemHeight,
                child: ColoredBox(
                  color: theme.selectedBackgroundColor,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            Column(
              children: [
                for (final (index, child) in children.indexed)
                  _sized(
                    index == 0
                        ? child
                        : DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: theme.tileBorderColor,
                                  width: theme.tileBorderWidth,
                                ),
                              ),
                            ),
                            child: child,
                          ),
                    selectedIndex != null,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sized(Widget child, bool forceHeight) {
    return forceHeight ? SizedBox(height: itemHeight, child: child) : child;
  }
}
