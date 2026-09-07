import 'package:flutter/material.dart';

import '../theme/list_item_container_theme.dart';

/// Wraps a list of items (typically [ListItemTile]s) with a themed,
/// rounded-corner container — no outer margin of its own; the caller
/// decides spacing. A thin divider is drawn between adjacent items only,
/// not above the first or below the last.
class ListItemContainer extends StatelessWidget {
  const ListItemContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ListItemContainerThemeData>()!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(theme.borderRadius),
      child: ColoredBox(
        color: theme.backgroundColor,
        child: Column(
          children: [
            for (final (index, child) in children.indexed)
              if (index == 0)
                child
              else
                DecoratedBox(
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
          ],
        ),
      ),
    );
  }
}
