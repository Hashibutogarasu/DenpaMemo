import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../pages/denpa_men_selection.dart';
import '../providers/denpa_men_providers.dart';
import '../routing/app_router.dart';
import 'container/selection_tile.dart';
import 'label/joined_labels_text.dart';

/// Field for picking [DenpaMen.parentIds]: either empty or exactly 2
/// parents, chosen via [DenpaMenSelectionRoute].
class EditableParents extends ConsumerWidget {
  const EditableParents({
    super.key,
    required this.denpaMen,
    required this.masterData,
    required this.onChanged,
  });

  final DenpaMen denpaMen;
  final MasterData masterData;
  final ValueChanged<DenpaMen> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final records = ref.watch(denpaMenListProvider(masterData)).value ?? [];
    final selectedNames = [
      for (final record in records)
        if (denpaMen.parentIds.contains(record.denpaMen.id))
          record.denpaMen.name,
    ];

    return SelectionTile(
      label: t.editableStatus.parents,
      onTap: () async {
        final result = await DenpaMenSelectionRoute(
          $extra: DenpaMenSelectionArgs(
            excludeId: denpaMen.id,
            initialSelectedIds: denpaMen.parentIds,
            maxSelectable: 2,
          ),
        ).push<List<DenpaMenRecord>>(context);
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
