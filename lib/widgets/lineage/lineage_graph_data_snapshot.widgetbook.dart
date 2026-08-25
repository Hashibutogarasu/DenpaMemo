import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../providers/denpa_men_providers.dart';
import '../../providers/qr_code_providers.dart';
import '../../widgetbook/denpa_men/route_denpa_men_data.dart';
import 'lineage_graph_data_snapshot.dart';

@widgetbook.UseCase(name: 'Default', type: List<Object?>, path: 'lineage')
Widget lineageDataSnapshotUseCase(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final qrCodes = ref.watch(qrCodeListProvider).value ?? [];
      final denpaMenRecords =
          ref.watch(denpaMenListProvider(RouteDenpaMenData.masterData)).value ?? [];
      final snapshot = lineageDataSnapshot(qrCodes, denpaMenRecords);

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(snapshot.toString()),
      );
    },
  );
}
