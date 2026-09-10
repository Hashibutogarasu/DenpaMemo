import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../../i18n/gen/strings.g.dart';
import 'resistance_bonus_selection_dialog.dart';

/// Shows [ResistanceBonusSelectionDialog] over [attributes], translating its
/// generic id/value result to and from [initial]'s
/// [AdditionalCorrection.attributeResistances] /
/// [AdditionalCorrection.attributeResistanceName] — the attribute-resistance
/// half of a [DenpaMen]'s "additional corrections" bundle (as opposed to a
/// shared [Correction]). Returns [initial] with just that half replaced, or
/// null if cancelled.
Future<AdditionalCorrection?> showAttributeResistanceSelectionDialog(
  BuildContext context, {
  required List<Attribute> attributes,
  required AdditionalCorrection initial,
}) async {
  final t = context.t;
  final result = await showResistanceBonusSelectionDialog(
    context,
    title: t.editableStatus.additionalAttributeResistance,
    options: [
      for (final attribute in attributes)
        (id: attribute.id, label: t.attribute[attribute.id] ?? attribute.id),
    ],
    initialValues: {
      for (final resistance in initial.attributeResistances)
        resistance.attribute.id: resistance.value,
    },
    initialName: initial.attributeResistanceName,
  );
  if (result == null) {
    return null;
  }
  final attributesById = {
    for (final attribute in attributes) attribute.id: attribute,
  };
  return initial.copyWith(
    attributeResistanceName: result.name,
    attributeResistances: [
      for (final entry in result.values.entries)
        AttributeResistance(
          attribute: attributesById[entry.key]!,
          value: entry.value,
        ),
    ],
  );
}
