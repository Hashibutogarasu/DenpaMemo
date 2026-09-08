import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/sign_in_status_provider.dart';
import '../theme/list_item_container_theme.dart';

/// Domain-agnostic row for any list of items: an optional [leading]
/// widget (or plain [icon]), a label, and a trailing slot that adapts to
/// what's passed in — checkbox, action menu, chevron, [trailing]/
/// [trailingText], or (when [checkable]) a check mark. [selected] tints
/// the row; for a [checkable] row, that tint and the check mark are one
/// sliding layer rather than two separately animated properties. When
/// [requiresSignIn] is true, [onTap] and [onLongPress] are treated as
/// unset (making the row non-interactive) unless [signInStatusProvider]
/// reports the user is signed in.
class ListItemTile extends ConsumerWidget {
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
    this.checkable = false,
    this.onSelectedChanged,
    this.actionMenuItemsBuilder,
    this.onLongPress,
    this.requiresSignIn = false,
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
  final bool checkable;
  final ValueChanged<bool>? onSelectedChanged;
  final List<PopupMenuEntry<VoidCallback>> Function(BuildContext)?
  actionMenuItemsBuilder;
  final VoidCallback? onLongPress;
  final bool requiresSignIn;

  static const _checkSlotWidth = 24.0;
  static const _checkSlotPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<ListItemContainerThemeData>()!;
    final signedIn = requiresSignIn ? ref.watch(signInStatusProvider) : true;
    final effectiveOnTap = signedIn ? onTap : null;
    final effectiveOnLongPress = signedIn ? onLongPress : null;
    final enabled =
        effectiveOnTap != null ||
        effectiveOnLongPress != null ||
        (selectionMode && onSelectedChanged != null);
    final effectiveColor = enabled ? color : null;
    final showCheckbox = selectionMode && onSelectedChanged != null;
    final showActionMenu = !showCheckbox && actionMenuItemsBuilder != null;
    final effectiveLeading =
        leading ?? (icon != null ? Icon(icon, color: effectiveColor) : null);

    final tile = ListTile(
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
                    : checkable
                    ? const SizedBox(width: _checkSlotWidth)
                    : (effectiveOnTap != null
                          ? const Icon(Icons.chevron_right)
                          : null)),
      enabled: enabled,
      onTap: showCheckbox
          ? () => onSelectedChanged!(!selected)
          : effectiveOnTap,
      onLongPress: effectiveOnLongPress,
    );

    if (!checkable) {
      return AnimatedContainer(
        duration: theme.checkAnimationDuration,
        curve: theme.checkAnimationInCurve,
        color: selected ? theme.selectedBackgroundColor : Colors.transparent,
        child: tile,
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: AnimatedSlide(
              duration: theme.checkAnimationDuration,
              curve: selected
                  ? theme.checkAnimationInCurve
                  : theme.checkAnimationOutCurve,
              offset: selected ? Offset.zero : const Offset(0, 1),
              child: ColoredBox(
                color: theme.selectedBackgroundColor,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: _checkSlotPadding,
                    child: Icon(
                      Icons.check,
                      size: _checkSlotWidth,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        tile,
      ],
    );
  }
}
