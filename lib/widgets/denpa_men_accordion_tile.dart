import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../pages/denpa_men_editor.dart';
import '../providers/denpa_men_providers.dart';
import '../routing/app_router.dart';
import '../theme/app_colors.dart';
import 'container/status.dart';
import 'denpa_men_status.dart';
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
  });

  final DenpaMenRecord record;
  final MasterData masterData;

  @override
  ConsumerState<DenpaMenAccordionTile> createState() =>
      _DenpaMenAccordionTileState();
}

enum _TileAction { edit, delete }

class _DenpaMenAccordionTileState extends ConsumerState<DenpaMenAccordionTile> {
  static const _animationDuration = Duration(milliseconds: 200);

  bool _expanded = false;

  Future<void> _delete(BuildContext context) async {
    final t = context.t;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.home.deleteConfirmTitle),
        content: Text(t.home.deleteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.common.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.common.delete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      ref.read(denpaMenRepositoryProvider).delete(widget.record.id);
    }
  }

  void _handleAction(BuildContext context, _TileAction action) {
    switch (action) {
      case _TileAction.edit:
        AddDenpaMenRoute(
          $extra: DenpaMenEditorArgs(
            masterData: widget.masterData,
            initial: widget.record,
          ),
        ).push(context);
      case _TileAction.delete:
        _delete(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final denpaMen = widget.record.denpaMen;

    return StatusContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _expanded ? 0 : 1,
                    child: Row(
                      children: [
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
              PopupMenuButton<_TileAction>(
                icon: const Icon(Icons.more_vert, color: AppColors.accent),
                onSelected: (action) => _handleAction(context, action),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: _TileAction.edit,
                    child: Text(t.common.edit),
                  ),
                  PopupMenuItem(
                    value: _TileAction.delete,
                    child: Text(t.common.delete),
                  ),
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => setState(() => _expanded = !_expanded),
                child: AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: _animationDuration,
                  child: const Icon(Icons.expand_more, color: AppColors.accent),
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: _animationDuration,
            alignment: Alignment.topCenter,
            child: _expanded
                ? DenpaMenStatus.fromDenpaMen(
                    denpaMen,
                    totalAttributeCount: widget.masterData.attributes.length,
                    showContainer: false,
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
