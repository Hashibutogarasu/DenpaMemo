import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/denpa_men/denpa_men.dart';
import '../../providers/master_data_providers.dart';
import '../denpa_men_status.dart';

/// Shows [denpaMen]'s read-only preview ([DenpaMenStatus]) in a dialog,
/// used when tapping an individual's node in
/// [DenpaMenLineageTree](../denpa_men_lineage_tree.dart) and when long
/// pressing a candidate in [DenpaMenListTile](../denpa_men_list_tile.dart).
class DenpaMenPreviewDialog extends ConsumerWidget {
  const DenpaMenPreviewDialog({super.key, required this.denpaMen});

  final DenpaMen denpaMen;

  static Future<void> show(BuildContext context, {required DenpaMen denpaMen}) {
    return showDialog<void>(
      context: context,
      builder: (context) => DenpaMenPreviewDialog(denpaMen: denpaMen),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalAttributeCount =
        ref.watch(masterDataProvider).value?.attributes.length ?? 0;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 760),
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
