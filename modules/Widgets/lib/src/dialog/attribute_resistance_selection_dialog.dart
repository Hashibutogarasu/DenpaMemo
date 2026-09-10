import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../../i18n/gen/strings.g.dart';
import 'resistance_bonus_selection_dialog.dart';

/// Shows [ResistanceBonusSelectionDialog] over [attributes], translating
/// its generic id/value result to and from [AttributeResistance]s for the
/// "additional corrections" attribute-resistance bundle a [DenpaMen] may
/// carry directly (as opposed to a shared [Correction]).
Future<({String name, List<AttributeResistance> resistances})?>
showAttributeResistanceSelectionDialog(
  BuildContext context, {
  required List<Attribute> attributes,
  required List<AttributeResistance> selected,
  required String name,
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
      for (final resistance in selected)
        resistance.attribute.id: resistance.value,
    },
    initialName: name,
  );
  if (result == null) {
    return null;
  }
  final attributesById = {
    for (final attribute in attributes) attribute.id: attribute,
  };
  return (
    name: result.name,
    resistances: [
      for (final entry in result.values.entries)
        AttributeResistance(
          attribute: attributesById[entry.key]!,
          value: entry.value,
        ),
    ],
  );
}
