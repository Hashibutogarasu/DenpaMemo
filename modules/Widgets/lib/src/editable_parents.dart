import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../i18n/gen/strings.g.dart';
import 'container/selection_tile.dart';
import 'label/joined_labels_text.dart';

/// Field for picking [DenpaMen.parentIds]: either empty or exactly 2
/// parents, chosen via [onPickParents].
class EditableParents extends StatelessWidget {
  const EditableParents({
    super.key,
    required this.denpaMen,
    required this.records,
    required this.onPickParents,
    required this.onChanged,
  });

  final DenpaMen denpaMen;
  final List<DenpaMenRecord> records;
  final Future<List<DenpaMenRecord>?> Function(BuildContext) onPickParents;
  final ValueChanged<DenpaMen> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final selectedNames = [
      for (final record in records)
        if (denpaMen.parentIds.contains(record.denpaMen.id))
          record.denpaMen.name,
    ];

    return SelectionTile(
      label: t.editableStatus.parents,
      onTap: () async {
        final result = await onPickParents(context);
        if (result != null) {
          onChanged(
            denpaMen.copyWith(
              parentIds: [for (final record in result) record.denpaMen.id],
            ),
          );
        }
      },
      child: JoinedLabelsText(labels: selectedNames),
    );
  }
}
