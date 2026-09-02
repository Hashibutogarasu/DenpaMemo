import 'package:flutter/material.dart';

/// A single row for any list of items: a leading icon, a label, and a
/// trailing slot that varies by what the caller passes in — a checkbox
/// (selection mode), a `⋮` action menu, a chevron (navigable), plain text,
/// or nothing.
///
/// Passing only [icon]/[label]/[onTap]/[trailingText]/[color] reproduces
/// the settings-list tile this was generalized from exactly; the
/// selection/action-menu parameters are additive.
class ListItemTile extends StatelessWidget {
  const ListItemTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.trailingText,
    this.color,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectedChanged,
    this.actionMenuItemsBuilder,
    this.onLongPress,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? trailingText;
  final Color? color;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectedChanged;
  final List<PopupMenuEntry<VoidCallback>> Function(BuildContext)? actionMenuItemsBuilder;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final enabled =
        onTap != null || onLongPress != null || (selectionMode && onSelectedChanged != null);
    final effectiveColor = enabled ? color : null;
    final showCheckbox = selectionMode && onSelectedChanged != null;
    final showActionMenu = !showCheckbox && actionMenuItemsBuilder != null;
    return ListTile(
      leading: Icon(icon, color: effectiveColor),
      title: Text(label, style: effectiveColor != null ? TextStyle(color: effectiveColor) : null),
      trailing: showCheckbox
          ? Checkbox(value: selected, onChanged: (value) => onSelectedChanged!(value ?? false))
          : showActionMenu
          ? PopupMenuButton<VoidCallback>(
              icon: const Icon(Icons.more_vert),
              onSelected: (action) => action(),
              itemBuilder: actionMenuItemsBuilder!,
            )
          : onTap != null
          ? const Icon(Icons.chevron_right)
          : (trailingText != null ? Text(trailingText!) : null),
      enabled: enabled,
      onTap: showCheckbox ? () => onSelectedChanged!(!selected) : onTap,
      onLongPress: onLongPress,
    );
  }
}
