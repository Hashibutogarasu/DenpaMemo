import 'package:flutter/material.dart';

import '../../domain/denpa_men/denpa_men.dart';
import '../denpa_men_status.dart';

/// Shows [denpaMen]'s read-only preview ([DenpaMenStatus]) in a dialog,
/// used when tapping an individual's node in
/// [DenpaMenLineageTree](../denpa_men_lineage_tree.dart).
class DenpaMenPreviewDialog extends StatelessWidget {
  const DenpaMenPreviewDialog({
    super.key,
    required this.denpaMen,
    required this.totalAttributeCount,
  });

  final DenpaMen denpaMen;
  final int totalAttributeCount;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 640),
        child: SingleChildScrollView(
          child: DenpaMenStatus.fromDenpaMen(
            denpaMen,
            totalAttributeCount: totalAttributeCount,
            showIcon: true,
          ),
        ),
      ),
    );
  }
}
