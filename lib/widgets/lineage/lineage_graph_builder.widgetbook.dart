import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../providers/denpa_men_providers.dart';
import '../../providers/qr_code_providers.dart';
import '../../widgetbook/denpa_men/route_denpa_men_data.dart';
import 'lineage_graph_builder.dart';

@widgetbook.UseCase(name: 'Default', type: LineageGraphData, path: 'lineage')
Widget lineageGraphDataUseCase(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final qrCodes = ref.watch(qrCodeListProvider).value ?? [];
      final denpaMenRecords =
          ref.watch(denpaMenListProvider(RouteDenpaMenData.masterData)).value ?? [];
      final data = buildLineageGraphData(
        qrCodes: qrCodes,
        denpaMenRecords: denpaMenRecords,
      );

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'nodes: ${data.nodeInfoByKey.length}\n'
          'edges: ${data.graph.edges.length}\n'
          'individuals: ${data.denpaMenById.length}',
        ),
      );
    },
  );
}
