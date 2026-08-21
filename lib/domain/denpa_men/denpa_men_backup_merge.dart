import '../master_data/master_data.dart';
import '../qr_code/qr_code_repository.dart';
import 'denpa_men.dart';
import 'denpa_men_backup_entry.dart';
import 'denpa_men_hash.dart';
import 'denpa_men_repository.dart';

/// Per-entry classification produced by [mergeDenpaMenBackupEntries]:
/// whether the merged [DenpaMen] was newly inserted or updated an existing
/// cuid-matching record.
enum DenpaMenMergeOutcome { added, merged }

/// One entry's result from [mergeDenpaMenBackupEntries]: the merged
/// [DenpaMen] as saved (its [DenpaMen.hash] recomputed, its
/// [DenpaMen.qrCodeId] repointed if a matching [QrCode] was reused)
/// paired with whether it was newly added or merged over an existing
/// record.
class DenpaMenMergeResult {
  const DenpaMenMergeResult({required this.denpaMen, required this.outcome});

  final DenpaMen denpaMen;
  final DenpaMenMergeOutcome outcome;
}

/// Merges [entries] into local storage.
///
/// Each entry's [DenpaMen] is matched against existing records by
/// [DenpaMen.id] (a cuid): a match is updated in place, otherwise a new
/// record is inserted. Each entry's [DenpaMenBackupEntry.qrCode], if any, is
/// matched by [QrCode.hash]: a match is reused (its cuid replaces the
/// imported [QrCode.id] on the merged individual's [DenpaMen.qrCodeId]),
/// otherwise the imported [QrCode] is inserted as-is. The merged
/// [DenpaMen.hash] is always recomputed rather than trusted from the
/// imported file. Returns each entry's outcome, in order.
List<DenpaMenMergeResult> mergeDenpaMenBackupEntries(
  List<DenpaMenBackupEntry> entries, {
  required DenpaMenRepository denpaMenRepository,
  required QrCodeRepository qrCodeRepository,
  required MasterData masterData,
}) {
  final results = <DenpaMenMergeResult>[];
  for (final entry in entries) {
    var denpaMen = entry.denpaMen;
    final qrCode = entry.qrCode;
    if (qrCode != null) {
      final existingQrCode = qrCodeRepository.findByHash(qrCode.hash);
      if (existingQrCode != null) {
        denpaMen = denpaMen.copyWith(qrCodeId: existingQrCode.qrCode.id);
      } else {
        qrCodeRepository.saveWithDenpaMens(qrCode, const [], masterData);
        denpaMen = denpaMen.copyWith(qrCodeId: qrCode.id);
      }
    }
    denpaMen = denpaMen.copyWith(hash: computeDenpaMenHash(denpaMen));
    final existing = denpaMenRepository.findByCuid(denpaMen.id, masterData);
    denpaMenRepository.save(denpaMen, id: existing?.id ?? 0);
    results.add(
      DenpaMenMergeResult(
        denpaMen: denpaMen,
        outcome: existing == null
            ? DenpaMenMergeOutcome.added
            : DenpaMenMergeOutcome.merged,
      ),
    );
  }
  return results;
}
