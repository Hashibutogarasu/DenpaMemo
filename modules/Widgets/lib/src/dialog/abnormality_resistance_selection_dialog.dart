import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../../i18n/gen/strings.g.dart';
import 'resistance_bonus_selection_dialog.dart';

/// Shows [ResistanceBonusSelectionDialog] over [abnormalityTypes],
/// translating its generic id/value result to and from
/// [AbnormalityResistance]s for the "additional corrections"
/// abnormality-resistance bundle a [DenpaMen] may carry directly (as
/// opposed to a shared [Correction]).
Future<({String name, List<AbnormalityResistance> resistances})?>
showAbnormalityResistanceSelectionDialog(
  BuildContext context, {
  required List<AbnormalityType> abnormalityTypes,
  required List<AbnormalityResistance> selected,
  required String name,
}) async {
  final t = context.t;
  final result = await showResistanceBonusSelectionDialog(
    context,
    title: t.editableStatus.additionalAbnormalityResistance,
    options: [
      for (final type in abnormalityTypes)
        (id: type.id, label: t.abnormality[type.id] ?? type.id),
    ],
    initialValues: {
      for (final resistance in selected)
        resistance.abnormalityId: resistance.value,
    },
    initialName: name,
  );
  if (result == null) {
    return null;
  }
  return (
    name: result.name,
    resistances: [
      for (final entry in result.values.entries)
        AbnormalityResistance(abnormalityId: entry.key, value: entry.value),
    ],
  );
}
