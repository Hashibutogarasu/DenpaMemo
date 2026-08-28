import 'dm_import_error.dart';
import 'import_result.dart';
import 'package:data_pack/data_pack.dart';

/// Builds the final [ImportResult] from every entry's [DenpaMenMergeResult]
/// plus whatever entries failed to parse ([failedEntries]). An individual
/// is [ImportResult.orphaned] when any of its [DenpaMen.parentIds] cannot
/// be resolved in [repository] even after this same import batch has been
/// merged in (so parent/child pairs imported together are not falsely
/// flagged).
ImportResult buildImportResult(
  List<DenpaMenMergeResult> mergeResults,
  List<DenpaMenEntryParseError> failedEntries, {
  required DenpaMenRepository repository,
  required MasterData masterData,
}) {
  final added = <DenpaMen>[];
  final merged = <DenpaMen>[];
  final orphaned = <DenpaMen>[];
  for (final result in mergeResults) {
    (result.outcome == DenpaMenMergeOutcome.added ? added : merged).add(result.denpaMen);
    final hasMissingParent = result.denpaMen.parentIds.any(
      (parentId) => repository.findByCuid(parentId, masterData) == null,
    );
    if (hasMissingParent) {
      orphaned.add(result.denpaMen);
    }
  }
  return ImportResult(added: added, merged: merged, orphaned: orphaned, failed: failedEntries);
}
