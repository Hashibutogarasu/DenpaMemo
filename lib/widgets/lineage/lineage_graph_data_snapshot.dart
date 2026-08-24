import 'package:collection/collection.dart';

import '../../domain/denpa_men/denpa_men_record.dart';
import '../../domain/qr_code/qr_code_record.dart';

typedef DenpaMenSignature = (
  String id,
  String? qrCodeId,
  List<String> parentIds,
  int? catchOrder,
  String name,
);

const _snapshotEquality = DeepCollectionEquality();

/// Captures the parts of [qrCodes]/[denpaMenRecords] that affect
/// [LineageGraph](lineage_graph.dart)'s node/edge structure (ids,
/// parentage, catch order, names) so [lineageDataSnapshotsEqual] can tell
/// whether the tree actually needs to be rebuilt.
List<Object?> lineageDataSnapshot(
  List<QrCodeRecord> qrCodes,
  List<DenpaMenRecord> denpaMenRecords,
) {
  final qrIds = qrCodes.map((r) => r.qrCode.id).sorted();
  final denpaMenSignatures = denpaMenRecords
      .map<DenpaMenSignature>(
        (r) => (
          r.denpaMen.id,
          r.denpaMen.qrCodeId,
          r.denpaMen.parentIds,
          r.denpaMen.catchOrder,
          r.denpaMen.name,
        ),
      )
      .sortedBy((signature) => signature.$1);
  return [qrIds, denpaMenSignatures];
}

bool lineageDataSnapshotsEqual(List<Object?> a, List<Object?> b) =>
    _snapshotEquality.equals(a, b);
