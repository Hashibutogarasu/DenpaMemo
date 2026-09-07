import 'dart:io';

import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import 'icon/entity_icon.dart';
import 'list/list_item_tile.dart';

/// [ListItemTile] view for a [DenpaMen] row: a resolved icon leading, the
/// name as label, and a trailing slot that swaps between a checkmark, a
/// selection checkbox, and an edit menu. [onLongPress] fires on
/// long-press when [enableLongPressPreview] is true (its default); when
/// false, long-pressing instead enters selection mode.
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

    return ListItemTile(
      leading: onSelectedChanged == null
          ? leadingIcon
          : InkWell(
              customBorder: const CircleBorder(),
              onTap: selectionMode ? null : () => onSelectedChanged!(!selected),
              child: leadingIcon,
            ),
      label: denpaMen.name,
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
          : const SizedBox.shrink(),
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
    );
  }
}
