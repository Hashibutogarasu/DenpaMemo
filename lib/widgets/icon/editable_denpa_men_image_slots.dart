import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/gen/strings.g.dart';
import 'editable_denpa_men_icon.dart';

/// Bundles all three [DenpaMenImageSlotType] icons (`face`, `wholeBody`,
/// `icon`) for [denpaMenId], each independently editable via
/// [EditableDenpaMenIcon]. Used as the `icon` slot of `AddDenpaMen` in the
/// `DenpaMenEditor` page, which lays that slot out next to a stat gauge
/// that needs the rest of the row's width — so this widget is clipped to
/// the exact same [size]×[size] footprint a single icon used to occupy,
/// with the three icons reachable by scrolling horizontally inside it,
/// rather than growing the row to fit all three side by side.
class EditableDenpaMenImageSlots extends ConsumerWidget {
  const EditableDenpaMenImageSlots({
    super.key,
    required this.denpaMenId,
    required this.size,
  });

  final String denpaMenId;
  final double size;

  String _labelFor(DenpaMenImageSlotType slot) {
    switch (slot) {
      case DenpaMenImageSlotType.face:
        return t.settings.clippingFace;
      case DenpaMenImageSlotType.wholeBody:
        return t.settings.clippingWholeBody;
      case DenpaMenImageSlotType.icon:
        return t.settings.clippingIcon;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconSize = size * 0.7;
    return SizedBox(
      width: size,
      height: size,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final slot in DenpaMenImageSlotType.values)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Tooltip(
                message: _labelFor(slot),
                child: EditableDenpaMenIcon(
                  denpaMenId: denpaMenId,
                  slot: slot,
                  size: iconSize,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
