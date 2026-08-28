import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';


typedef DenpaMenSignature = (
  String id,
  String? qrCodeId,
  List<String> parentIds,
  int? newCatchOrder,
  String name,
);

const _snapshotEquality = DeepCollectionEquality();

/// Captures the parts of [qrCodes]/[denpaMenRecords] that affect
/// [LineageGraph](lineage_graph.dart)'s node/edge structure (ids,
/// parentage, resolved catch order, names) so [lineageDataSnapshotsEqual]
/// can tell whether the tree actually needs to be rebuilt.
List<Object?> lineageDataSnapshot(
  List<QrCodeRecord> qrCodes,
  List<DenpaMenRecord> denpaMenRecords,
) {
  final qrIds = qrCodes.map((r) => r.qrCode.id).sorted();
  final denpaMenById = {
    for (final r in denpaMenRecords) r.denpaMen.id: r.denpaMen,
  };
  final denpaMenSignatures = denpaMenRecords
      .map<DenpaMenSignature>(
        (r) => (
          r.denpaMen.id,
          r.denpaMen.qrCodeId,
          r.denpaMen.parentIds,
          r.denpaMen.newCatchOrder(denpaMenById),
          r.denpaMen.name,
        ),
      )
      .sortedBy((signature) => signature.$1);
  return [qrIds, denpaMenSignatures];
}

bool lineageDataSnapshotsEqual(List<Object?> a, List<Object?> b) =>
    _snapshotEquality.equals(a, b);
