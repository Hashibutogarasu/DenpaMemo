import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import 'dialog/denpa_men_action_menu.dart';
import 'dialog/denpa_men_preview_dialog.dart';
import 'icon/denpa_men_icon.dart';

/// Shared row layout for lists of [DenpaMen] candidates: an icon, the
/// name, and an optional selection checkmark or checkbox. Used by
/// [DenpaMenSelectionDialog](dialog/denpa_men_selection_dialog.dart),
/// [showParentDenpaMenSelectionDialog](dialog/parent_denpa_men_selection_dialog.dart),
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

  /// Whether the enclosing list is in multi-select mode. When true, the
  /// leading checkbox and the row body both toggle selection instead of
  /// invoking [onTap].
  final bool selectionMode;

  final bool selected;

  /// Invoked with the new selection state when the leading checkbox is
  /// tapped, or when the row is tapped while [selectionMode] is true.
  /// Leave null to hide the checkbox and disable selection (read-only
  /// usage, e.g. [BackupResultSection]).
  final ValueChanged<bool>? onSelectedChanged;

  /// Invoked when the row is tapped while [selectionMode] is false.
  final VoidCallback? onTap;

  /// Whether long-pressing the row opens [DenpaMenPreviewDialog]. Mobile
  /// home lists pass false, since long-press isn't used as an entry point
  /// into selection mode there (the leading checkbox is used instead).
  final bool enableLongPressPreview;

  /// When set together with [masterData] (mobile home list), a trailing
  /// edit/delete menu is shown, mirroring
  /// [DenpaMenAccordionTile](denpa_men_accordion_tile.dart). Left null for
  /// read-only or selection-picker usage.
  final DenpaMenRecord? record;

  /// See [record].
  final MasterData? masterData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = this.record;
    final masterData = this.masterData;
    final showActionMenu = !selectionMode && record != null && masterData != null;
    final leadingIcon = DenpaMenIcon(denpaMenId: denpaMen.id, size: 40);

    return ListTile(
      leading: onSelectedChanged == null
          ? leadingIcon
          : selectionMode
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: selected,
                  onChanged: (value) => onSelectedChanged!(value ?? false),
                ),
                leadingIcon,
              ],
            )
          : InkWell(
              customBorder: const CircleBorder(),
              onTap: () => onSelectedChanged!(!selected),
              child: leadingIcon,
            ),
      title: Text(denpaMen.name),
      selected: selected,
      trailing: showActionMenu
          ? PopupMenuButton<DenpaMenAction>(
              icon: const Icon(Icons.more_vert),
              onSelected: (action) => handleDenpaMenAction(
                context,
                ref,
                action,
                record: record,
                masterData: masterData,
              ),
              itemBuilder: (context) => denpaMenActionMenuItems(
                context,
                hasParents: denpaMen.parentIds.isNotEmpty,
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
          : null,
    );
  }
}
