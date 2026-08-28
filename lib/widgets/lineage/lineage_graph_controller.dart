import 'package:flutter/widgets.dart';

import '../../domain/denpa_men/denpa_men_record.dart';
import '../../domain/qr_code/qr_code_record.dart';
import 'lineage_graph_builder.dart';
import 'lineage_graph_data_snapshot.dart';
import 'node_info.dart';

/// Owns [LineageGraph](lineage_graph.dart)'s graph/selection/hover state,
/// independent of the widget tree, so the graph-diffing and value-holder
/// logic can be reasoned about (and reused) without a [BuildContext].
class LineageGraphController {
  LineageGraphController({
    required List<QrCodeRecord> qrCodes,
    required List<DenpaMenRecord> denpaMenRecords,
  }) : _dataSnapshotValue = lineageDataSnapshot(qrCodes, denpaMenRecords),
       graphData = buildLineageGraphData(
         qrCodes: qrCodes,
         denpaMenRecords: denpaMenRecords,
       );

  List<Object?> _dataSnapshotValue;
  LineageGraphData graphData;
  int generation = 0;

  final hoveredBredId = ValueNotifier<String?>(null);
  final selectionMode = ValueNotifier<bool>(false);
  final selectedIds = ValueNotifier<Set<int>>({});
  final nodeEntriesByNodeKey = <Object, (GlobalKey, NodeInfo)>{};

  bool refreshIfChanged(
    List<QrCodeRecord> qrCodes,
    List<DenpaMenRecord> denpaMenRecords,
  ) {
    final newSnapshot = lineageDataSnapshot(qrCodes, denpaMenRecords);
    if (lineageDataSnapshotsEqual(newSnapshot, _dataSnapshotValue)) {
      return false;
    }
    _dataSnapshotValue = newSnapshot;
    forceRefresh(qrCodes, denpaMenRecords);
    return true;
  }

  void forceRefresh(
    List<QrCodeRecord> qrCodes,
    List<DenpaMenRecord> denpaMenRecords,
  ) {
    generation++;
    nodeEntriesByNodeKey.clear();
    graphData = buildLineageGraphData(
      qrCodes: qrCodes,
      denpaMenRecords: denpaMenRecords,
    );
  }

  void dispose() {
    hoveredBredId.dispose();
    selectionMode.dispose();
    selectedIds.dispose();
  }
}
