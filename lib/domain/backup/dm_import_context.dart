import 'dart:io';

import '../denpa_men/denpa_men.dart';
import '../denpa_men/denpa_men_backup_entry.dart';
import '../denpa_men/denpa_men_backup_merge.dart';
import '../denpa_men/denpa_men_repository.dart';
import '../master_data/master_data.dart';
import '../qr_code/qr_code_repository.dart';
import 'dm_import_error.dart';
import 'import_result.dart';

/// Mutable working state shared across a `.dm` import's steps (see
/// `DmImportStep`). Each step reads what earlier steps produced and fills
/// in its own fields for later steps to use.
class DmImportContext {
  DmImportContext({
    required this.inputFile,
    required this.masterData,
    required this.denpaMenRepository,
    required this.qrCodeRepository,
    required this.loadIcon,
    required this.saveIcon,
    required this.resolveDuplicates,
    required this.onProgress,
  });

  final File inputFile;
  final MasterData masterData;
  final DenpaMenRepository denpaMenRepository;
  final QrCodeRepository qrCodeRepository;
  final Future<File?> Function(String denpaMenId) loadIcon;
  final Future<void> Function(String denpaMenId, File iconFile) saveIcon;

  /// Called only when the import contains individuals that already exist
  /// locally (matched by cuid). Returns the subset of [candidates] to
  /// import, or null/empty to cancel the whole import.
  final Future<List<DenpaMen>?> Function(List<DenpaMen> candidates)
  resolveDuplicates;

  final void Function(double? progress) onProgress;

  Directory? tempRoot;
  Directory? extractDirectory;
  String? headerComment;
  List<DenpaMenBackupEntry>? entries;
  List<DenpaMenEntryParseError>? failedEntries;
  Map<String, File>? iconsByDenpaMenId;
  List<DenpaMen>? candidates;
  List<DenpaMen>? toImport;
  List<DenpaMenBackupEntry>? selectedEntries;
  List<DenpaMenMergeResult>? mergeResults;
  ImportResult? importResult;
}
