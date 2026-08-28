import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/master_data/antenna_display_name.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/responsive_providers.dart';
import '../routing/app_router.dart';
import 'editable_parents.dart';
import 'icon/editable_denpa_men_icon.dart';

/// Right-hand desktop pane letting the user edit [denpaMen] in place. Name
/// and numeric stats are edited inline; head shape, body color, and
/// corrections open a [showHeadShapeSelectionDialog] /
/// [showBodyColorSelectionDialog] / [showCorrectionSelectionDialog].
///
/// Every edit produces a full draft [DenpaMen] via [onChanged] so the caller
/// can re-derive resistances (e.g. through `createDenpaMen`) and update the
/// read-only status area immediately.
class EditableDenpaMenStatus extends ConsumerWidget {
  const EditableDenpaMenStatus({
    super.key,
    required this.denpaMen,
    required this.headShapes,
    required this.anntenas,
    required this.corrections,
    required this.masterData,
    required this.qrCodeCandidates,
    required this.onChanged,
    required this.considerCorrections,
    required this.onConsiderCorrectionsChanged,
    this.qrCodeEditable = true,
  });

  final DenpaMen denpaMen;
  final List<HeadShape> headShapes;
  final List<Anntena> anntenas;
  final List<Correction> corrections;
  final MasterData masterData;
  final List<QrCodeRecord> qrCodeCandidates;
  final ValueChanged<DenpaMen> onChanged;
  final bool considerCorrections;
  final ValueChanged<bool> onConsiderCorrectionsChanged;
  final bool qrCodeEditable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final isMobile = ref.watch(isMobileLayoutProvider);

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
          IndentedHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EditableDenpaMenIcon(denpaMenId: denpaMen.id, size: 56),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (isMobile) ...[
                              InlineGaugeLabel(
                                label: t.denpaMenStatus.level,
                                value: GaugeValue(
                                  current: denpaMen.level,
                                  max: denpaMen.maxLevel,
                                ),
                                onCurrentChanged: (value) =>
                                    onChanged(denpaMen.copyWith(level: value)),
                                onMaxChanged: (value) => onChanged(
                                  denpaMen.copyWith(maxLevel: value),
                                ),
                              ),
                              const SizedBox(height: 4),
                              InlineGaugeLabel(
                                label: t.denpaMenStatus.happiness,
                                value: GaugeValue(
                                  current: denpaMen.happiness,
                                  max: denpaMen.maxHappiness,
                                ),
                                onCurrentChanged: (value) => onChanged(
                                  denpaMen.copyWith(happiness: value),
                                ),
                                onMaxChanged: (value) => onChanged(
                                  denpaMen.copyWith(maxHappiness: value),
                                ),
                              ),
                            ] else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: InlineGaugeLabel(
                                      label: t.denpaMenStatus.level,
                                      value: GaugeValue(
                                        current: denpaMen.level,
                                        max: denpaMen.maxLevel,
                                      ),
                                      onCurrentChanged: (value) => onChanged(
                                        denpaMen.copyWith(level: value),
                                      ),
                                      onMaxChanged: (value) => onChanged(
                                        denpaMen.copyWith(maxLevel: value),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: InlineGaugeLabel(
                                      label: t.denpaMenStatus.happiness,
                                      value: GaugeValue(
                                        current: denpaMen.happiness,
                                        max: denpaMen.maxHappiness,
                                      ),
                                      onCurrentChanged: (value) => onChanged(
                                        denpaMen.copyWith(happiness: value),
                                      ),
                                      onMaxChanged: (value) => onChanged(
                                        denpaMen.copyWith(maxHappiness: value),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            OutlinedInlineNameField(
                              value: denpaMen.name,
                              onChanged: (value) =>
                                  onChanged(denpaMen.copyWith(name: value)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 2,
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                  color: AppColors.accent,
                ),
              ],
            ),
          ),
          EditableExp(denpaMen: denpaMen, onChanged: onChanged),
          const SizedBox(height: 8),
          SelectionTile(
            label: t.editableStatus.monsterExp,
            onTap: () async {
              final result = await MonsterExpRoute(
                $extra: denpaMen.monsterExp,
              ).push<MonsterExp>(context);
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
                    t.headShape[denpaMen.headShape.id] ?? denpaMen.headShape.id,
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
              ),
            ],
          ),
          const SizedBox(height: 8),
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
              antennaDisplayName(t, denpaMen.anntena, denpaMen.antennaLevel),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
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
          const SizedBox(height: 8),
          EditableParents(
            denpaMen: denpaMen,
            masterData: masterData,
            onChanged: onChanged,
          ),
          const SizedBox(height: 8),
          EditableQrCode(
            denpaMen: denpaMen,
            candidates: qrCodeCandidates,
            onChanged: onChanged,
            enabled: qrCodeEditable,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
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
