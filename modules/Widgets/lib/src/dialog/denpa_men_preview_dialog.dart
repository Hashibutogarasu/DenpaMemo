import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../denpa_men_status.dart';

/// Shows [denpaMen]'s read-only preview ([DenpaMenStatus]) in a dialog,
/// used when tapping an individual's node in the app's lineage tree and
/// when long pressing a candidate in
/// [DenpaMenListTile](../denpa_men_list_tile.dart).
class DenpaMenPreviewDialog extends StatelessWidget {
  const DenpaMenPreviewDialog({
    super.key,
    required this.denpaMen,
    required this.totalAttributeCount,
    this.iconFile,
  });

  final DenpaMen denpaMen;
  final int totalAttributeCount;
  final File? iconFile;

  static Future<void> show(
    BuildContext context, {
    required DenpaMen denpaMen,
    required int totalAttributeCount,
    File? iconFile,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => DenpaMenPreviewDialog(
        denpaMen: denpaMen,
        totalAttributeCount: totalAttributeCount,
        iconFile: iconFile,
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
          ),
        ),
      ),
    );
  }
}
