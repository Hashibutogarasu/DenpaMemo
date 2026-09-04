import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import 'dialog/media_zoom_dialog.dart';
import 'denpa_men_selected_overlay.dart';
import 'icon/entity_icon.dart';

/// One candidate image for [DenpaMenContainer]'s tap-to-zoom expansion:
/// [priority] mirrors `ClippingSlot.priority` (lower shown first). Callers
/// pass these unsorted — [DenpaMenContainer] does the priority sort
/// itself when the zoom button is tapped, so it (and its widget tests)
/// never need an app-layer provider to already have ordered the list.
typedef DenpaMenZoomCandidate = ({int priority, File file, String? label});

/// Compact, icon-only grid cell for a [DenpaMen], used by [DenpaMenBox].
/// Unlike [DenpaMenListTile](denpa_men_list_tile.dart) it has no name
/// label and no overflow menu, but shares the same tap/long-press
/// selection behavior. [iconFile] is an already-resolved icon (or null
/// for a placeholder) and is always what's shown on the grid cell itself
/// — [zoomCandidates], when non-empty, only ever affects what the
/// tap-to-zoom overlay opens.
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
    this.zoomCandidates,
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
  final List<DenpaMenZoomCandidate>? zoomCandidates;
  final double size;

  /// Sorts [candidates] by ascending priority and opens them in a
  /// [MediaZoomDialog]. Shared by every place that shows a `DenpaMen`'s
  /// zoomable images (this container's own corner button, and
  /// [DenpaMenStatus](denpa_men_status.dart)'s icon when it's given
  /// candidates), so the priority-ordering behavior stays identical
  /// wherever it's used.
  static Future<void> show(
    BuildContext context,
    List<DenpaMenZoomCandidate> candidates,
  ) {
    final sorted = List<DenpaMenZoomCandidate>.from(candidates)
      ..sort((a, b) => a.priority.compareTo(b.priority));
    return MediaZoomDialog.show(
      context,
      images: [for (final candidate in sorted) candidate.file],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasZoomCandidates =
        zoomCandidates != null && zoomCandidates!.isNotEmpty;
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
          if (hasZoomCandidates)
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => DenpaMenContainer.show(context, zoomCandidates!),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.zoom_in,
                    size: size * 0.35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
