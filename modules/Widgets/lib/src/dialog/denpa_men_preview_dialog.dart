import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../denpa_men_container.dart';
import '../denpa_men_status.dart';

/// Shows [denpaMen]'s read-only preview ([DenpaMenStatus]) in a dialog,
/// used when tapping an individual's node in the app's lineage tree and
/// when long pressing a candidate in
/// [DenpaMenListTile](../denpa_men_list_tile.dart). When [zoomCandidates]
/// is given, tapping the preview's icon opens it (and any other slot
/// images) in a [MediaZoomDialog](media_zoom_dialog.dart).
class DenpaMenPreviewDialog extends StatelessWidget {
  const DenpaMenPreviewDialog({
    super.key,
    required this.denpaMen,
    required this.totalAttributeCount,
    this.iconFile,
    this.zoomCandidates,
  });

  final DenpaMen denpaMen;
  final int totalAttributeCount;
  final File? iconFile;
  final List<DenpaMenZoomCandidate>? zoomCandidates;

  static Future<void> show(
    BuildContext context, {
    required DenpaMen denpaMen,
    required int totalAttributeCount,
    File? iconFile,
    List<DenpaMenZoomCandidate>? zoomCandidates,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => DenpaMenPreviewDialog(
        denpaMen: denpaMen,
        totalAttributeCount: totalAttributeCount,
        iconFile: iconFile,
        zoomCandidates: zoomCandidates,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 760),
        child: SingleChildScrollView(
          child: DenpaMenStatus.fromDenpaMen(
            denpaMen,
            totalAttributeCount: totalAttributeCount,
            showIcon: true,
            iconFile: iconFile,
            zoomCandidates: zoomCandidates,
          ),
        ),
      ),
    );
  }
}
