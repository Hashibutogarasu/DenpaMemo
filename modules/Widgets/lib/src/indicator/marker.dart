import 'package:flutter/material.dart';

/// Visual style of a [Marker] row: [plain] (no decoration), [separator]
/// (horizontal rule segments flanking the content, for a standalone status
/// line), or [border] (a bottom border, for stacking as a list of
/// entries).
enum MarkerVariant { plain, separator, border }

/// A single icon-plus-text row — a small, generic building block for
/// status/activity lines (e.g. "Reviewed 8 related files", a step in a
/// progress list). Compose it with [MarkerIcon] and [MarkerContent].
class Marker extends StatelessWidget {
  const Marker({super.key, this.variant = MarkerVariant.plain, required this.children});

  final MarkerVariant variant;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final row = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (variant == MarkerVariant.separator) Expanded(child: Divider(color: theme.dividerColor)),
        if (variant == MarkerVariant.separator) const SizedBox(width: 8),
        ...children,
        if (variant == MarkerVariant.separator) const SizedBox(width: 8),
        if (variant == MarkerVariant.separator) Expanded(child: Divider(color: theme.dividerColor)),
      ],
    );
    return DefaultTextStyle(
      style: (theme.textTheme.bodySmall ?? const TextStyle()).copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 16),
        padding: variant == MarkerVariant.border
            ? const EdgeInsets.only(bottom: 8)
            : EdgeInsets.zero,
        decoration: variant == MarkerVariant.border
            ? BoxDecoration(border: Border(bottom: BorderSide(color: theme.dividerColor)))
            : null,
        child: row,
      ),
    );
  }
}

/// A fixed-size icon slot for a [Marker].
class MarkerIcon extends StatelessWidget {
  const MarkerIcon({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(width: 16, height: 16, child: child);
}

/// The text/content slot for a [Marker].
class MarkerContent extends StatelessWidget {
  const MarkerContent({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Expanded(child: child);
}
