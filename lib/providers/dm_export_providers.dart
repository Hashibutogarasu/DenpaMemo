import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../domain/backup/dm_file.dart';
import '../domain/backup/export_result.dart';
import '../domain/master_data/master_data.dart';
import 'denpa_men_icon_providers.dart';
import 'denpa_men_providers.dart';
import 'import_export_progress_providers.dart';
import 'qr_code_providers.dart';

/// Drives the "export selected individuals to a `.dm` file" flow: prompts
/// for a save location (defaulting the file name via
/// [DMFile.defaultExportFileName]), then delegates the actual data
/// processing to [DMFile.writeExport], reporting progress through
/// [importExportProgressProvider] throughout.
class DmExportController {
  const DmExportController(this._ref);

  final Ref _ref;

  /// Returns the [ExportResult] once the export completes, or null if the
  /// user cancelled the save dialog.
  Future<ExportResult?> exportSelected(
    MasterData masterData, {
    required String dialogTitle,
  }) async {
    final progress = _ref.read(importExportProgressProvider.notifier);
    progress.state = 0;

    final selectedIds = _ref.read(selectedDenpaMenIdsProvider);
    final records = _ref.read(denpaMenRepositoryProvider).getAll(masterData);
    final candidates = [
      for (final record in records)
        if (selectedIds.contains(record.id)) record.denpaMen,
    ];

    final savePath = await FilePicker.saveFile(
      dialogTitle: dialogTitle,
      fileName: DMFile.defaultExportFileName(
        exportedAt: DateTime.now(),
        individualCount: candidates.length,
      ),
      type: FileType.custom,
      allowedExtensions: [DMFile.extension],
    );
    if (savePath == null) {
      progress.state = null;
      return null;
    }

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final qrCodes = _ref.read(qrCodeRepositoryProvider).getAll();
      final storage = _ref.read(denpaMenIconStorageProvider);
      return await DMFile.writeExport(
        candidates: candidates,
        masterData: masterData,
        qrCodes: [for (final record in qrCodes) record.qrCode],
        loadIcon: storage.loadIcon,
        savePath: savePath,
        dataVersion: packageInfo.version,
        onProgress: (value) => progress.state = value,
      );
    } finally {
      progress.state = null;
    }
  }
}

final dmExportControllerProvider = Provider<DmExportController>(
  (ref) => DmExportController(ref),
);
