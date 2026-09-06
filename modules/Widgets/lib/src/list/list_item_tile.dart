import 'package:flutter/material.dart';

/// Domain-agnostic row for any list of items: an optional [leading]
/// widget (or plain [icon]), a label, and a trailing slot that adapts to
/// what's passed in — checkbox, action menu, chevron, [trailing]/
/// [trailingText], or nothing.
class ListItemTile extends StatelessWidget {
  const ListItemTile({
    super.key,
    this.icon,
    this.leading,
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
  final Widget? leading;
  final String label;
  final Widget? subtitle;
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
    final effectiveLeading =
        leading ?? (icon != null ? Icon(icon, color: effectiveColor) : null);
    return ListTile(
      leading: effectiveLeading,
      title: Text(
        label,
        style: effectiveColor != null ? TextStyle(color: effectiveColor) : null,
      ),
      subtitle: subtitle,
      selected: selected,
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
          : trailing ??
                (trailingText != null
                    ? Text(trailingText!)
                    : onTap != null
                    ? const Icon(Icons.chevron_right)
                    : null),
      enabled: enabled,
      onTap: showCheckbox ? () => onSelectedChanged!(!selected) : onTap,
      onLongPress: onLongPress,
    );
  }
}
