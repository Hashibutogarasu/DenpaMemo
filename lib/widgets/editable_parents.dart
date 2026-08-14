import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../i18n/gen/strings.g.dart';
import 'container/selection_tile.dart';
import 'dialog/parent_denpa_men_selection_dialog.dart';

/// Field for picking [DenpaMen.parentIds]: either empty or exactly 2 parents,
/// chosen from [candidates] (existing individuals, self already excluded) via
/// [showParentDenpaMenSelectionDialog].
class EditableParents extends StatelessWidget {
  const EditableParents({
    super.key,
    required this.denpaMen,
    required this.candidates,
    required this.onChanged,
  });

  final DenpaMen denpaMen;
  final List<DenpaMenRecord> candidates;
  final ValueChanged<DenpaMen> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final selected = [
      for (final record in candidates)
        if (denpaMen.parentIds.contains(record.denpaMen.id)) record,
    ];

    return SelectionTile(
      label: t.editableStatus.parents,
      onTap: () async {
        final result = await showParentDenpaMenSelectionDialog(
          context,
          candidates: candidates,
          selected: selected,
        );
        if (result != null) {
          onChanged(
            denpaMen.copyWith(
              parentIds: [for (final record in result) record.denpaMen.id],
            ),
          );
        }
      },
      child: Text(
        selected.isEmpty
            ? t.common.unset
            : selected.map((record) => record.denpaMen.name).join('、'),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
