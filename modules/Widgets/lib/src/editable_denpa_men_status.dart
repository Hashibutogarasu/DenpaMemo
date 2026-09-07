import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../i18n/gen/strings.g.dart';
import 'color/color_dot.dart';
import 'container/nested.dart';
import 'container/selection_tile.dart';
import 'container/status.dart';
import 'dialog/antenna_selection_dialog.dart';
import 'dialog/body_color_selection_dialog.dart';
import 'dialog/correction_selection_dialog.dart';
import 'dialog/head_shape_selection_dialog.dart';
import 'domain/antenna_display_name.dart';
import 'editable_exp.dart';
import 'editable_parents.dart';
import 'editable_qr_code.dart';
import 'editable_stat_grid.dart';
import 'field/inline_text_field.dart';
import 'field/outlined_inline_name_field.dart';
import 'label/gauge_pair_row.dart';
import 'label/gauge_value.dart';
import 'label/inline_gauge_label.dart';
import 'label/joined_labels_text.dart';
import 'list/list_item_container.dart';
import 'responsive/responsive_scope.dart';
import 'theme/denpa_men_container_theme.dart';

typedef PhysiqueIdentification = ({Physique physique, int? columnIndex});

/// Right-hand desktop pane letting the user edit [denpaMen] in place. Every
/// edit produces a full draft [DenpaMen] via [onChanged] so the caller can
/// re-derive resistances (e.g. through `createDenpaMen`) and update the
/// read-only status area immediately.
class EditableDenpaMenStatus extends StatelessWidget {
  const EditableDenpaMenStatus({
    super.key,
    required this.denpaMen,
    required this.headShapes,
    required this.anntenas,
    required this.corrections,
    required this.qrCodeCandidates,
    required this.onChanged,
    required this.considerCorrections,
    required this.onConsiderCorrectionsChanged,
    required this.icon,
    required this.parentCandidates,
    required this.onPickParents,
    required this.onPickMonsterExp,
    required this.onIdentifyPhysique,
    this.qrCodeEditable = true,
  });

  final DenpaMen denpaMen;
  final List<HeadShape> headShapes;
  final List<Anntena> anntenas;
  final List<Correction> corrections;
  final List<QrCodeRecord> qrCodeCandidates;
  final ValueChanged<DenpaMen> onChanged;
  final bool considerCorrections;
  final ValueChanged<bool> onConsiderCorrectionsChanged;
  final bool qrCodeEditable;

  final Widget icon;
  final List<DenpaMenRecord> parentCandidates;
  final Future<List<DenpaMenRecord>?> Function(BuildContext) onPickParents;
  final Future<MonsterExp?> Function(BuildContext) onPickMonsterExp;
  final Future<PhysiqueIdentification?> Function(BuildContext)
  onIdentifyPhysique;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final isMobile = ResponsiveScope.isMobileOf(context);
    final theme = Theme.of(context).extension<DenpaMenContainerThemeData>()!;

    return StatusContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GaugePairRow(
                          level: InlineGaugeLabel(
                            label: t.denpaMenStatus.level,
                            value: GaugeValue(
                              current: denpaMen.level,
                              max: denpaMen.maxLevel,
                            ),
                            onCurrentChanged: (value) =>
                                onChanged(denpaMen.copyWith(level: value)),
                            onMaxChanged: (value) =>
                                onChanged(denpaMen.copyWith(maxLevel: value)),
                          ),
                          happiness: InlineGaugeLabel(
                            label: t.denpaMenStatus.happiness,
                            value: GaugeValue(
                              current: denpaMen.happiness,
                              max: denpaMen.maxHappiness,
                            ),
                            onCurrentChanged: (value) =>
                                onChanged(denpaMen.copyWith(happiness: value)),
                            onMaxChanged: (value) => onChanged(
                              denpaMen.copyWith(maxHappiness: value),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        OutlinedInlineNameField(
                          value: denpaMen.name,
                          onChanged: (value) =>
                              onChanged(denpaMen.copyWith(name: value)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: theme.headerDividerHeight,
                margin: const EdgeInsets.only(top: 4, bottom: 4),
                color: theme.accentColor,
              ),
            ],
          ),
          EditableExp(denpaMen: denpaMen, onChanged: onChanged),
          const SizedBox(height: 8),
          ListItemContainer(
            children: [
              SelectionTile(
                label: t.editableStatus.monsterExp,
                onTap: () async {
                  final result = await onPickMonsterExp(context);
                  if (result != null) {
                    onChanged(denpaMen.copyWith(monsterExp: result));
                  }
                },
                child: Text(
                  denpaMen.monsterExp == null
                      ? t.common.unset
                      : t.monster[denpaMen.monsterExp!.monsterId] ??
                            denpaMen.monsterExp!.monsterId,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          NestedContainer(
            padding: const EdgeInsets.all(8),
            child: EditableStatGrid(
              denpaMen: denpaMen,
              onChanged: onChanged,
              considerCorrections: considerCorrections,
              columns: isMobile ? 1 : 2,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: considerCorrections,
                onChanged: (value) =>
                    onConsiderCorrectionsChanged(value ?? false),
              ),
              Expanded(child: Text(t.editableStatus.considerCorrections)),
            ],
          ),
          const SizedBox(height: 8),
          ListItemContainer(
            children: [
              SelectionTile(
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
                  t.headShape[denpaMen.headShape.id] ?? denpaMen.headShape.id,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SelectionTile(
                label: t.editableStatus.bodyColor,
                onTap: () async {
                  final result = await showBodyColorSelectionDialog(
                    context,
                    selected: denpaMen.bodyColors,
                    shades: denpaMen.bodyColorShades,
                    isSpColor: denpaMen.isSpColor,
                  );
                  if (result != null) {
                    onChanged(
                      denpaMen.copyWith(
                        bodyColors: result.bodyColors,
                        bodyColorShades: result.bodyColorShades,
                        isSpColor: result.isSpColor,
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < denpaMen.bodyColors.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: ColorDot(
                          colorId: denpaMen.bodyColors[i],
                          shadeLevel: i < denpaMen.bodyColorShades.length
                              ? denpaMen.bodyColorShades[i]
                              : 0,
                        ),
                      ),
                  ],
                ),
              ),
              SelectionTile(
                label: t.editableStatus.antenna,
                onTap: () async {
                  final result = await showAntennaSelectionDialog(
                    context,
                    anntenas: anntenas,
                    selected: denpaMen.anntena,
                    level: denpaMen.antennaLevel,
                  );
                  if (result != null) {
                    onChanged(
                      denpaMen.copyWith(
                        anntena: result.anntena,
                        antennaLevel: result.level,
                      ),
                    );
                  }
                },
                child: Text(
                  antennaDisplayName(
                    t,
                    denpaMen.anntena,
                    denpaMen.antennaLevel,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SelectionTile(
                label: t.editableStatus.physique,
                onTap: () async {
                  final result = await onIdentifyPhysique(context);
                  if (result != null) {
                    onChanged(
                      denpaMen.copyWith(
                        physique: result.physique,
                        physiqueColumnIndex: result.columnIndex,
                      ),
                    );
                  }
                },
                child: Text(
                  denpaMen.physiqueColumnIndex == null
                      ? t.common.unset
                      : t.physique[denpaMen.physique.id] ??
                            denpaMen.physique.id,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SelectionTile(
                label: t.editableStatus.correction,
                onTap: () async {
                  final selected = await showCorrectionSelectionDialog(
                    context,
                    corrections: corrections,
                    selected: denpaMen.corrections,
                  );
                  if (selected != null) {
                    onChanged(denpaMen.copyWith(corrections: selected));
                  }
                },
                child: JoinedLabelsText(
                  labels: [
                    for (final c in denpaMen.corrections)
                      t.correction[c.id] ?? c.id,
                  ],
                ),
              ),
              EditableParents(
                denpaMen: denpaMen,
                records: parentCandidates,
                onPickParents: onPickParents,
                onChanged: onChanged,
              ),
              EditableQrCode(
                denpaMen: denpaMen,
                candidates: qrCodeCandidates,
                onChanged: onChanged,
                enabled: qrCodeEditable,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.memoBackgroundColor,
              borderRadius: BorderRadius.circular(theme.memoBorderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.editableStatus.memo,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                InlineTextField(
                  value: denpaMen.memo ?? '',
                  multiline: true,
                  onChanged: (value) => onChanged(
                    denpaMen.copyWith(memo: value.isEmpty ? null : value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
