import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';
import 'container/status.dart';
import 'denpa_men_container.dart';
import 'denpa_men_status.dart';
import 'icon/entity_icon.dart';
import 'label/gauge_label.dart';
import 'label/gauge_value.dart';
import 'label/outlined_title.dart';
import 'theme/denpa_men_container_theme.dart';

/// Collapsed-by-default list entry for [denpaMen]. Header and (once
/// expanded) [DenpaMenStatus] share a single [StatusContainer] rather than
/// each having their own, so the tile reads as one continuous shape instead
/// of two stacked rounded boxes.
class DenpaMenAccordionTile extends StatefulWidget {
  const DenpaMenAccordionTile({
    super.key,
    required this.denpaMen,
    required this.totalAttributeCount,
    required this.selectionMode,
    required this.selected,
    required this.isCut,
    required this.onSelectedChanged,
    this.iconFile,
    this.zoomCandidates,
    this.actionMenuItemsBuilder,
    this.animationDuration,
  });

  final DenpaMen denpaMen;
  final int totalAttributeCount;
  final Duration? animationDuration;

  final bool selectionMode;
  final bool selected;
  final bool isCut;
  final ValueChanged<bool> onSelectedChanged;

  final File? iconFile;
  final List<DenpaMenZoomCandidate>? zoomCandidates;
  final List<PopupMenuEntry<VoidCallback>> Function(BuildContext)?
  actionMenuItemsBuilder;

  @override
  State<DenpaMenAccordionTile> createState() => _DenpaMenAccordionTileState();
}

class _DenpaMenAccordionTileState extends State<DenpaMenAccordionTile> {
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
    final denpaMen = widget.denpaMen;
    final theme = Theme.of(context).extension<DenpaMenContainerThemeData>()!;
    final animationDuration =
        widget.animationDuration ?? theme.accordionAnimationDuration;

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
                  width: theme.accordionCheckboxSlotSize,
                  height: theme.accordionCheckboxSlotSize,
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
                    borderRadius: BorderRadius.circular(
                      theme.statusBorderRadius,
                    ),
                    onTap: _handleTap,
                    onLongPress: _handleLongPress,
                    child: AnimatedOpacity(
                      duration: animationDuration,
                      opacity: _expanded ? 0 : 1,
                      child: Row(
                        children: [
                          ResolvedEntityIcon(
                            file: widget.iconFile,
                            size: theme.accordionIconSize,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: OutlinedTitleText(
                              text: denpaMen.name,
                              outlineColor: theme.accentColor,
                              fontSize: theme.accordionTitleFontSize,
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
                if (widget.actionMenuItemsBuilder != null)
                  PopupMenuButton<VoidCallback>(
                    icon: Icon(Icons.more_vert, color: theme.accentColor),
                    onSelected: (action) => action(),
                    itemBuilder: widget.actionMenuItemsBuilder!,
                  ),
                InkWell(
                  borderRadius: BorderRadius.circular(theme.statusBorderRadius),
                  onTap: _handleTap,
                  onLongPress: _handleLongPress,
                  child: AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: animationDuration,
                    child: Icon(Icons.expand_more, color: theme.accentColor),
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: animationDuration,
              alignment: Alignment.topCenter,
              child: _expanded
                  ? DenpaMenStatus.fromDenpaMen(
                      denpaMen,
                      totalAttributeCount: widget.totalAttributeCount,
                      showContainer: false,
                      showIcon: true,
                      iconFile: widget.iconFile,
                      zoomCandidates: widget.zoomCandidates,
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}
