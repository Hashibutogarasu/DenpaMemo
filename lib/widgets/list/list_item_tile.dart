import 'package:flutter/material.dart';

/// A single row for any list of items: an optional leading [icon], a
/// label, and a trailing slot that varies by what the caller passes in —
/// a checkbox (selection mode), a `⋮` action menu, a chevron (navigable),
/// [trailing], plain [trailingText], or nothing.
///
/// Passing only [icon]/[label]/[onTap]/[trailingText]/[color] reproduces
/// the settings-list tile this was generalized from exactly; the
/// selection/action-menu/[trailing] parameters are additive. [trailing]
/// takes priority over [trailingText] when both are given, for a trailing
/// slot that isn't plain text (e.g. a formatted-date widget).
class ListItemTile extends StatelessWidget {
  const ListItemTile({
    super.key,
    this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
    this.trailingText,
    this.trailing,
    this.color,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectedChanged,
    this.actionMenuItemsBuilder,
    this.onLongPress,
  });

  final IconData? icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final String? trailingText;
  final Widget? trailing;
  final Color? color;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectedChanged;
  final List<PopupMenuEntry<VoidCallback>> Function(BuildContext)?
  actionMenuItemsBuilder;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final enabled =
        onTap != null ||
        onLongPress != null ||
        (selectionMode && onSelectedChanged != null);
    final effectiveColor = enabled ? color : null;
    final showCheckbox = selectionMode && onSelectedChanged != null;
    final showActionMenu = !showCheckbox && actionMenuItemsBuilder != null;
    return ListTile(
      leading: icon != null ? Icon(icon, color: effectiveColor) : null,
      title: Text(
        label,
        style: effectiveColor != null ? TextStyle(color: effectiveColor) : null,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: showCheckbox
          ? Checkbox(
              value: selected,
              onChanged: (value) => onSelectedChanged!(value ?? false),
            )
          : showActionMenu
          ? PopupMenuButton<VoidCallback>(
              icon: const Icon(Icons.more_vert),
              onSelected: (action) => action(),
              itemBuilder: actionMenuItemsBuilder!,
            )
          : trailing != null
          ? trailing
          : trailingText != null
          ? Text(trailingText!)
          : onTap != null
          ? const Icon(Icons.chevron_right)
          : null,
      enabled: enabled,
      onTap: showCheckbox ? () => onSelectedChanged!(!selected) : onTap,
      onLongPress: onLongPress,
    );
  }
}
