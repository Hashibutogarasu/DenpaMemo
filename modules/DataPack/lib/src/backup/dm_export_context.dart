import 'dart:io';
import 'dart:typed_data';

import '../denpa_men/denpa_men.dart';
import '../denpa_men/denpa_men_backup_entry.dart';
import '../master_data/master_data.dart';
import '../qr_code/qr_code.dart';
import 'export_result.dart';

/// Mutable working state shared across a `.dm` export's steps (see
/// `DmExportStep`). Each step reads what earlier steps produced and fills
/// in its own fields for later steps to use. [loadIcons] returns every
/// image slot saved for a given individual, keyed by an opaque slot
/// identifier the caller defines (DMFile never enumerates or interprets
/// these keys itself — see `CopyIconsStep`); empty if it has none.
class DmExportContext {
  DmExportContext({
    required this.candidates,
    required this.masterData,
    required this.qrCodes,
    required this.loadIcons,
    required this.dataVersion,
    required this.onProgress,
    this.copyToPath,
  });

  final List<DenpaMen> candidates;
  final MasterData masterData;
  final List<QrCode> qrCodes;
  final Future<Map<String, File>> Function(String denpaMenId) loadIcons;
  final String dataVersion;
  final void Function(double? progress) onProgress;

  final String? copyToPath;

  List<DenpaMen>? consistent;
  ExportResult? exportResult;
  List<DenpaMenBackupEntry>? entries;
  Directory? tempRoot;
  Directory? workDirectory;
  File? zipFile;
  Uint8List? zipBytes;
}
