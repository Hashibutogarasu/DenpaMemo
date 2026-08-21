import 'dart:io';

import '../denpa_men/denpa_men.dart';
import '../denpa_men/denpa_men_backup_entry.dart';
import '../master_data/master_data.dart';
import '../qr_code/qr_code.dart';
import 'export_result.dart';

/// Mutable working state shared across a `.dm` export's steps (see
/// `DmExportStep`). Each step reads what earlier steps produced and fills
/// in its own fields for later steps to use.
class DmExportContext {
  DmExportContext({
    required this.candidates,
    required this.masterData,
    required this.qrCodes,
    required this.loadIcon,
    required this.savePath,
    required this.dataVersion,
    required this.onProgress,
  });

  final List<DenpaMen> candidates;
  final MasterData masterData;
  final List<QrCode> qrCodes;
  final Future<File?> Function(String denpaMenId) loadIcon;
  final String savePath;
  final String dataVersion;
  final void Function(double? progress) onProgress;

  List<DenpaMen>? consistent;
  ExportResult? exportResult;
  List<DenpaMenBackupEntry>? entries;
  Directory? tempRoot;
  Directory? workDirectory;
  File? zipFile;
}
