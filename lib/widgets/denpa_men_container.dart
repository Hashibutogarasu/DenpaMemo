import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import 'dialog/denpa_men_preview_dialog.dart';
import 'icon/denpa_men_icon.dart';

/// Compact, icon-only grid cell for a [DenpaMen], used by [DenpaMenBox].
/// Unlike [DenpaMenListTile](denpa_men_list_tile.dart) it has no name
/// label and no overflow menu, but shares the same tap/long-press
/// selection behavior.
class DenpaMenContainer extends StatelessWidget {
  const DenpaMenContainer({
    super.key,
    required this.denpaMen,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectedChanged,
    this.onTap,
    this.enableLongPressPreview = true,
    this.size = 56,
  });

  final DenpaMen denpaMen;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectedChanged;
  final VoidCallback? onTap;
  final bool enableLongPressPreview;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectionMode && onSelectedChanged != null) {
          onSelectedChanged!(!selected);
        } else {
          onTap?.call();
        }
      },
      onLongPress: enableLongPressPreview
          ? () => DenpaMenPreviewDialog.show(context, denpaMen: denpaMen)
          : onSelectedChanged != null
          ? () {
              if (!selectionMode) {
                onSelectedChanged!(true);
              }
            }
          : null,
      child: Stack(
        children: [
          DenpaMenIcon(denpaMenId: denpaMen.id, size: size),
          if (selected)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.4),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_box,
                  color: Colors.white,
                  size: size * 0.4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
