import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import 'dialog/denpa_men_action_menu.dart';
import 'dialog/denpa_men_preview_dialog.dart';
import 'icon/denpa_men_icon.dart';

/// Shared row layout for lists of [DenpaMen] candidates: an icon, the
/// name, and a trailing slot that swaps between a selection checkmark, a
/// selection checkbox, and an edit menu. Used by
/// [DenpaMenSelectionDialog](dialog/denpa_men_selection_dialog.dart),
/// [DenpaMenSelectionPage](../pages/denpa_men_selection.dart),
/// read-only result dialogs (leaving [onTap] null renders a
/// non-interactive tile), and the mobile home individual list.
class DenpaMenListTile extends ConsumerWidget {
  const DenpaMenListTile({
    super.key,
    required this.denpaMen,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectedChanged,
    this.onTap,
    this.enableLongPressPreview = true,
    this.record,
    this.masterData,
  });

  final DenpaMen denpaMen;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectedChanged;
  final VoidCallback? onTap;
  final bool enableLongPressPreview;
  final DenpaMenRecord? record;
  final MasterData? masterData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = this.record;
    final masterData = this.masterData;
    final showActionMenu =
        !selectionMode && record != null && masterData != null;
    final leadingIcon = DenpaMenIcon(denpaMenId: denpaMen.id, size: 40);

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
                itemBuilder: (context) => denpaMenActionMenuItems(
                  context,
                  ref,
                  record: record,
                  masterData: masterData,
                ),
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
            ? () => DenpaMenPreviewDialog.show(context, denpaMen: denpaMen)
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
