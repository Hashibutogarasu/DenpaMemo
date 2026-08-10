import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../theme/app_colors.dart';
import 'container/status.dart';
import 'denpa_men_status.dart';
import 'dialog/denpa_men_action_menu.dart';
import 'icon/denpa_men_icon.dart';
import 'label/gauge_label.dart';
import 'label/gauge_value.dart';
import 'label/outlined_title.dart';

/// Collapsed-by-default list entry for a saved [DenpaMenRecord]. Header and
/// (once expanded) [DenpaMenStatus] share a single [StatusContainer] rather
/// than each having their own, so the tile reads as one continuous shape
/// instead of two stacked rounded boxes.
class DenpaMenAccordionTile extends ConsumerStatefulWidget {
  const DenpaMenAccordionTile({
    super.key,
    required this.record,
    required this.masterData,
    required this.selectionMode,
    required this.selected,
    required this.isCut,
    required this.onSelectedChanged,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  final DenpaMenRecord record;
  final MasterData masterData;

  /// Duration of the expand/collapse and rotation animations.
  final Duration animationDuration;

  /// Whether the home list is currently in multi-select mode. The checkbox
  /// slot is always reserved in the header regardless of this flag — only
  /// the [Checkbox] itself is swapped for an invisible placeholder — so
  /// entering/leaving selection mode never reflows the row.
  final bool selectionMode;

  /// Whether this tile is currently selected. Ignored when
  /// [selectionMode] is false.
  final bool selected;

  /// Whether this tile was cut and is pending a paste-driven removal;
  /// rendered greyed-out until then.
  final bool isCut;

  /// Invoked when the checkbox is toggled, the tile is tapped while
  /// [selectionMode] is true, or the tile is long-pressed while
  /// [selectionMode] is false (which enters selection mode by selecting
  /// this tile).
  final ValueChanged<bool> onSelectedChanged;

  @override
  ConsumerState<DenpaMenAccordionTile> createState() =>
      _DenpaMenAccordionTileState();
}

class _DenpaMenAccordionTileState extends ConsumerState<DenpaMenAccordionTile> {
  bool _expanded = false;

  void _handleTap() {
    if (widget.selectionMode) {
      widget.onSelectedChanged(!widget.selected);
    } else {
      setState(() => _expanded = !_expanded);
    }
  }

  void _handleLongPress() {
    if (!widget.selectionMode) {
      widget.onSelectedChanged(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final denpaMen = widget.record.denpaMen;

    return Opacity(
      opacity: widget.isCut ? 0.5 : 1,
      child: StatusContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: widget.selectionMode
                    ? Checkbox(
                        value: widget.selected,
                        onChanged: (value) =>
                            widget.onSelectedChanged(value ?? false),
                      )
                    : null,
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: _handleTap,
                  onLongPress: _handleLongPress,
                  child: AnimatedOpacity(
                    duration: widget.animationDuration,
                    opacity: _expanded ? 0 : 1,
                    child: Row(
                      children: [
                        DenpaMenIcon(denpaMenId: denpaMen.id, size: 32),
                        const SizedBox(width: 8),
                        Flexible(
                          child: OutlinedTitleText(
                            text: denpaMen.name,
                            outlineColor: AppColors.accent,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GaugeLabel(
                          label: t.denpaMenStatus.level,
                          value: GaugeValue(
                            current: denpaMen.level,
                            max: denpaMen.maxLevel,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PopupMenuButton<DenpaMenAction>(
                icon: const Icon(Icons.more_vert, color: AppColors.accent),
                onSelected: (action) => handleDenpaMenAction(
                  context,
                  ref,
                  action,
                  record: widget.record,
                  masterData: widget.masterData,
                ),
                itemBuilder: (context) => denpaMenActionMenuItems(
                  context,
                  hasParents: denpaMen.parentIds.isNotEmpty,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _handleTap,
                onLongPress: _handleLongPress,
                child: AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: widget.animationDuration,
                  child: const Icon(Icons.expand_more, color: AppColors.accent),
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: widget.animationDuration,
            alignment: Alignment.topCenter,
            child: _expanded
                ? DenpaMenStatus.fromDenpaMen(
                    denpaMen,
                    totalAttributeCount: widget.masterData.attributes.length,
                    showContainer: false,
                    showIcon: true,
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
      ),
    );
  }
}
