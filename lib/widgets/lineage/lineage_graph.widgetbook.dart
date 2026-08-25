import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../providers/denpa_men_providers.dart';
import '../../providers/qr_code_providers.dart';
import '../../widgetbook/denpa_men/route_denpa_men_data.dart';
import 'lineage_graph.dart';

@widgetbook.UseCase(name: 'Default', type: LineageGraph, path: 'lineage')
Widget lineageGraphUseCase(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      final qrCodes = ref.watch(qrCodeListProvider).value ?? [];
      final denpaMenRecords =
          ref.watch(denpaMenListProvider(RouteDenpaMenData.masterData)).value ?? [];

      return LineageGraph(
        qrCodes: qrCodes,
        denpaMenRecords: denpaMenRecords,
        masterData: RouteDenpaMenData.masterData,
        iconsById: const {},
      );
    },
  );
}
