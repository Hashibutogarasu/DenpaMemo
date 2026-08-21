import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/denpa_men/denpa_men.dart';
import '../icon/denpa_men_icon.dart';
import 'denpa_men_preview_dialog.dart';

/// Shared row layout for lists of [DenpaMen] candidates: an icon, the
/// name, an optional selection checkmark, and a long-press preview via
/// [DenpaMenPreviewDialog]. Used by
/// [DenpaMenSelectionDialog](denpa_men_selection_dialog.dart),
/// [showParentDenpaMenSelectionDialog](parent_denpa_men_selection_dialog.dart),
/// and read-only result dialogs (leaving [onTap] null renders a
/// non-interactive tile).
class DenpaMenSelectionListTile extends StatelessWidget {
  const DenpaMenSelectionListTile({
    super.key,
    required this.denpaMen,
    this.selected = false,
    this.onTap,
  });

  final DenpaMen denpaMen;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Consumer(
        builder: (context, ref, _) =>
            DenpaMenIcon(denpaMenId: denpaMen.id, size: 40),
      ),
      title: Text(denpaMen.name),
      selected: selected,
      trailing: selected ? const Icon(Icons.check) : null,
      onTap: onTap,
      onLongPress: () => DenpaMenPreviewDialog.show(context, denpaMen: denpaMen),
    );
  }
}
