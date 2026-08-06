import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/master_data/head_shape.dart';
import '../i18n/gen/strings.g.dart';
import '../theme/app_colors.dart';
import 'color/color_dot.dart';
import 'container/nested.dart';
import 'container/selection_tile.dart';
import 'container/status.dart';
import 'dialog/body_color_selection_dialog.dart';
import 'dialog/head_shape_selection_dialog.dart';
import 'editable_exp.dart';
import 'editable_stat_grid.dart';
import 'field/outlined_inline_name_field.dart';
import 'label/gauge_value.dart';
import 'label/inline_gauge_label.dart';

/// Right-hand desktop pane letting the user edit [denpaMen] in place. Name
/// and numeric stats are edited inline; head shape and body color open a
/// [showHeadShapeSelectionDialog] / [showBodyColorSelectionDialog].
///
/// Every edit produces a full draft [DenpaMen] via [onChanged] so the caller
/// can re-derive resistances (e.g. through `createDenpaMen`) and update the
/// read-only status area immediately.
class EditableDenpaMenStatus extends StatelessWidget {
  const EditableDenpaMenStatus({
    super.key,
    required this.denpaMen,
    required this.headShapes,
    required this.onChanged,
  });

  final DenpaMen denpaMen;
  final List<HeadShape> headShapes;
  final ValueChanged<DenpaMen> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return StatusContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.edit,
              size: 28,
              color: DefaultTextStyle.of(context).style.color,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InlineGaugeLabel(
                label: t.denpaMenStatus.level,
                value: GaugeValue(
                  current: denpaMen.level,
                  max: denpaMen.maxLevel,
                ),
                onChanged: (value) =>
                    onChanged(denpaMen.copyWith(level: value)),
              ),
              InlineGaugeLabel(
                label: t.denpaMenStatus.happiness,
                value: GaugeValue(
                  current: denpaMen.happiness,
                  max: denpaMen.maxHappiness,
                ),
                onChanged: (value) =>
                    onChanged(denpaMen.copyWith(happiness: value)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: OutlinedInlineNameField(
              value: denpaMen.name,
              onChanged: (value) => onChanged(denpaMen.copyWith(name: value)),
            ),
          ),
          Container(
            height: 2,
            margin: const EdgeInsets.only(left: 14, top: 4, bottom: 4),
            color: AppColors.accent,
          ),
          EditableExp(denpaMen: denpaMen, onChanged: onChanged),
          const SizedBox(height: 8),
          NestedContainer(
            padding: const EdgeInsets.all(8),
            child: EditableStatGrid(denpaMen: denpaMen, onChanged: onChanged),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SelectionTile(
                  label: t.editableStatus.headShape,
                  onTap: () async {
                    final selected = await showHeadShapeSelectionDialog(
                      context,
                      headShapes: headShapes,
                      selected: denpaMen.headShape,
                    );
                    if (selected != null) {
                      onChanged(denpaMen.copyWith(headShape: selected));
                    }
                  },
                  child: Text(
                    t.headShape[denpaMen.headShape.id] ??
                        denpaMen.headShape.displayName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SelectionTile(
                  label: t.editableStatus.bodyColor,
                  onTap: () async {
                    final result = await showBodyColorSelectionDialog(
                      context,
                      selected: denpaMen.bodyColors,
                      isSpColor: denpaMen.isSpColor,
                    );
                    if (result != null) {
                      onChanged(
                        denpaMen.copyWith(
                          bodyColors: result.bodyColors,
                          isSpColor: result.isSpColor,
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final colorId in denpaMen.bodyColors)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: ColorDot(colorId: colorId),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
