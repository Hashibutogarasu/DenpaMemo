import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/analysis_menu_theme.dart';

/// A single, non-interactive [AnalysisMenu] cell: [id] names the icon asset
/// (`assets/data/icons/menu/<id>.png`) and doubles as the key a future
/// feature would hook into, while [label] is the text shown under it.
class AnalysisMenuItem {
  const AnalysisMenuItem({required this.id, required this.label});

  final String id;
  final String label;
}

/// A grid of square, rounded-rectangle cards (icon above label) for the
/// analysis page's menu. Column count and cell styling come from
/// [AnalysisMenuThemeData]; this widget only lays [items] out, wrapping into
/// rows like [SearchStatGrid], since the item count is small and fixed.
/// Cells are purely visual and carry no tap behavior.
class AnalysisMenu extends StatelessWidget {
  const AnalysisMenu({super.key, required this.items});

  final List<AnalysisMenuItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AnalysisMenuThemeData>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = math.max(
          0.0,
          (constraints.maxWidth - theme.spacing * (theme.columns - 1)) /
              theme.columns,
        );
        return Wrap(
          spacing: theme.spacing,
          runSpacing: theme.spacing,
          children: [
            for (final item in items)
              SizedBox(
                width: columnWidth,
                height: columnWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: BorderRadius.circular(theme.borderRadius),
                  ),
                  child: Padding(
                    padding: theme.padding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/data/icons/menu/${item.id}.png',
                          width: theme.iconSize,
                          height: theme.iconSize,
                        ),
                        SizedBox(height: theme.spacing),
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: theme.foregroundColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
