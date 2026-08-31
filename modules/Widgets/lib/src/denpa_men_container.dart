import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import 'denpa_men_selected_overlay.dart';
import 'icon/entity_icon.dart';

/// Compact, icon-only grid cell for a [DenpaMen], used by [DenpaMenBox].
/// Unlike [DenpaMenListTile](denpa_men_list_tile.dart) it has no name
/// label and no overflow menu, but shares the same tap/long-press
/// selection behavior. [iconFile] is an already-resolved icon (or null
/// for a placeholder).
class DenpaMenContainer extends StatelessWidget {
  const DenpaMenContainer({
    super.key,
    required this.denpaMen,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectedChanged,
    this.onTap,
    this.enableLongPressPreview = true,
    this.onLongPress,
    this.iconFile,
    this.size = 56,
  });

  final DenpaMen denpaMen;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectedChanged;
  final VoidCallback? onTap;
  final bool enableLongPressPreview;
  final ValueChanged<DenpaMen>? onLongPress;
  final File? iconFile;
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
          ? (onLongPress == null ? null : () => onLongPress!(denpaMen))
          : onSelectedChanged != null
          ? () {
              if (!selectionMode) {
                onSelectedChanged!(true);
              }
            }
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ResolvedEntityIcon(file: iconFile, size: size),
          if (selected)
            SizedBox(
              width: size,
              height: size,
              child: const DenpaMenSelectedOverlay(),
            ),
        ],
      ),
    );
  }
}
