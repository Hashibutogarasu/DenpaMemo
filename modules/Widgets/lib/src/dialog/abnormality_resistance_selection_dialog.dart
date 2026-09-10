import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../../i18n/gen/strings.g.dart';
import 'resistance_bonus_selection_dialog.dart';

/// Shows [ResistanceBonusSelectionDialog] over [abnormalityTypes],
/// translating its generic id/value result to and from [initial]'s
/// [AdditionalCorrection.abnormalityResistances] /
/// [AdditionalCorrection.abnormalityResistanceName] — the
/// abnormality-resistance half of a [DenpaMen]'s "additional corrections"
/// bundle (as opposed to a shared [Correction]). Returns [initial] with just
/// that half replaced, or null if cancelled.
Future<AdditionalCorrection?> showAbnormalityResistanceSelectionDialog(
  BuildContext context, {
  required List<AbnormalityType> abnormalityTypes,
  required AdditionalCorrection initial,
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
      for (final resistance in initial.abnormalityResistances)
        resistance.abnormalityId: resistance.value,
    },
    initialName: initial.abnormalityResistanceName,
  );
  if (result == null) {
    return null;
  }
  return initial.copyWith(
    abnormalityResistanceName: result.name,
    abnormalityResistances: [
      for (final entry in result.values.entries)
        AbnormalityResistance(abnormalityId: entry.key, value: entry.value),
    ],
  );
}
