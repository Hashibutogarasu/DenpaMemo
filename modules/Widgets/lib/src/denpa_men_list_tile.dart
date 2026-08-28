import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import 'icon/entity_icon.dart';

/// Shared row layout for lists of [DenpaMen] candidates: an icon, the
/// name, and a trailing slot that swaps between a selection checkmark, a
/// selection checkbox, and an edit menu. [iconFile] is an already-resolved
/// icon (or null for a placeholder); [actionMenuItemsBuilder] supplies the
/// trailing overflow menu's items, or omit it to hide the menu entirely.
/// [onLongPress] fires on long-press when [enableLongPressPreview] is true
/// (its default); when false, long-pressing instead enters selection mode
/// via [onSelectedChanged], the same as tapping while [selectionMode] is
/// already active.
class DenpaMenListTile extends StatelessWidget {
  const DenpaMenListTile({
    super.key,
    required this.denpaMen,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectedChanged,
    this.onTap,
    this.enableLongPressPreview = true,
    this.onLongPress,
    this.iconFile,
    this.actionMenuItemsBuilder,
  });

  final DenpaMen denpaMen;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectedChanged;
  final VoidCallback? onTap;
  final bool enableLongPressPreview;
  final ValueChanged<DenpaMen>? onLongPress;
  final File? iconFile;
  final List<PopupMenuEntry<VoidCallback>> Function(BuildContext)?
  actionMenuItemsBuilder;

  @override
  Widget build(BuildContext context) {
    final showActionMenu = !selectionMode && actionMenuItemsBuilder != null;
    final leadingIcon = ResolvedEntityIcon(file: iconFile, size: 40);

    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        leading: onSelectedChanged == null
            ? leadingIcon
            : InkWell(
                customBorder: const CircleBorder(),
                onTap: selectionMode
                    ? null
                    : () => onSelectedChanged!(!selected),
                child: leadingIcon,
              ),
        title: Text(denpaMen.name),
        selected: selected,
        trailing: selectionMode && onSelectedChanged != null
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
            : onSelectedChanged == null && selected
            ? const Icon(Icons.check)
            : null,
        onTap: () {
          if (selectionMode && onSelectedChanged != null) {
            onSelectedChanged!(!selected);
          } else {
            onTap?.call();
          }
        },
        onLongPress: enableLongPressPreview
            ? (onLongPress == null ? null : () => onLongPress!(denpaMen))
            : onSelectedChanged != null
            ? () {
                if (!selectionMode) {
                  onSelectedChanged!(true);
                }
              }
            : null,
      ),
    );
  }
}
