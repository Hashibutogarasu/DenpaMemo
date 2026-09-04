import 'dart:io';

import 'dm_import_error.dart';
import 'import_result.dart';
import 'package:data_pack/data_pack.dart';

/// Mutable working state shared across a `.dm` import's steps (see
/// `DmImportStep`). Each step reads what earlier steps produced and fills
/// in its own fields for later steps to use. [loadIcons]/[saveIcons] read
/// back and write every image slot for a given individual at once, keyed
/// by an opaque slot identifier the caller defines (DMFile never
/// enumerates or interprets these keys itself — see
/// `ResolveIconsStep`/`SaveIconsStep`); [loadIcons] specifically reads
/// from local storage post-import, to warm `WarmIconCacheStep`'s cache.
class DmImportContext {
  DmImportContext({
    required this.inputFile,
    required this.masterData,
    required this.denpaMenRepository,
    required this.qrCodeRepository,
    required this.loadIcons,
    required this.saveIcons,
    required this.resolveDuplicates,
    required this.onProgress,
  });

  final File inputFile;
  final MasterData masterData;
  final DenpaMenRepository denpaMenRepository;
  final QrCodeRepository qrCodeRepository;

  final Future<Map<String, File>> Function(String denpaMenId) loadIcons;
  final Future<void> Function(String denpaMenId, Map<String, File> icons)
  saveIcons;

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

  Map<String, Map<String, File>>? iconsByDenpaMenId;
  List<DenpaMen>? candidates;
  List<DenpaMen>? toImport;
  List<DenpaMenBackupEntry>? selectedEntries;
  List<DenpaMenMergeResult>? mergeResults;
  ImportResult? importResult;
}
