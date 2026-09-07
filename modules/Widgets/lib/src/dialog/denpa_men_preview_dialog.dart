import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../denpa_men_status.dart';
import '../icon/denpa_men_icon_builder.dart';
import 'app_dialog.dart';

/// Shows [denpaMen]'s read-only preview ([DenpaMenStatus]) in a dialog,
/// used when tapping an individual's node in the app's lineage tree and
/// when long pressing a candidate in
/// [DenpaMenListTile](../denpa_men_list_tile.dart). [iconBuilder] backs
/// the preview's own icon.
class DenpaMenPreviewDialog extends StatelessWidget {
  const DenpaMenPreviewDialog({
    super.key,
    required this.denpaMen,
    required this.totalAttributeCount,
    this.iconBuilder,
  });

  final DenpaMen denpaMen;
  final int totalAttributeCount;
  final DenpaMenIconBuilder? iconBuilder;

  static Future<void> show(
    BuildContext context, {
    required DenpaMen denpaMen,
    required int totalAttributeCount,
    DenpaMenIconBuilder? iconBuilder,
  }) {
    return AppDialog.show<void>(
      context: context,
      builder: (context) => DenpaMenPreviewDialog(
        denpaMen: denpaMen,
        totalAttributeCount: totalAttributeCount,
        iconBuilder: iconBuilder,
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
            iconBuilder: iconBuilder,
          ),
        ),
      ),
    );
  }
}
