import 'package:flutter/material.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart';

/// Wraps a list of items (typically [ListItemTile]s) with a themed,
/// rounded-corner, outer-padded container. A thin divider (from
/// [ListItemContainerThemeData]) is drawn between adjacent items — not
/// above the first or below the last, since those edges already meet the
/// container's own rounded border.
class ListItemContainer extends StatelessWidget {
  const ListItemContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ListItemContainerThemeData>()!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
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
      ),
    );
  }
}
