import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../theme/app_colors.dart';
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
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.accent.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(4),
            child: DenpaMenIcon(denpaMenId: denpaMen.id, size: size - 8),
          ),
          if (selected)
            Positioned(
              right: -2,
              bottom: -2,
              child: CircleAvatar(
                radius: 9,
                backgroundColor: AppColors.accent,
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
