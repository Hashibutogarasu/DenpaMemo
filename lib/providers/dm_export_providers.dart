import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;

import '../domain/backup/dm_file.dart';
import '../i18n/gen/strings.g.dart';
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

    final fileName = DMFile.defaultExportFileName(
      exportedAt: DateTime.now(),
      individualCount: candidates.length,
    );

    String? copyToPath;
    if (Platform.isAndroid) {
      final directoryPath = await FilePicker.getDirectoryPath(
        dialogTitle: dialogTitle,
      );
      if (directoryPath == null) {
        progress.state = null;
        return null;
      }
      copyToPath = path.join(directoryPath, fileName);
    }

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final qrCodes = _ref.read(qrCodeRepositoryProvider).getAll();
      final storage = _ref.read(denpaMenIconStorageProvider);
      final (result, zipBytes) = await DMFile.writeExport(
        candidates: candidates,
        masterData: masterData,
        qrCodes: [for (final record in qrCodes) record.qrCode],
        loadIcon: storage.loadIcon,
        dataVersion: packageInfo.version,
        onProgress: (value) => progress.state = value,
        copyToPath: copyToPath,
      );

      if (copyToPath != null) {
        return result;
      }

      final savePath = await FilePicker.saveFile(
        dialogTitle: dialogTitle,
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: [DMFile.extension],
        bytes: zipBytes,
      );
      if (savePath == null) {
        return null;
      }
      return result;
    } finally {
      progress.state = null;
    }
  }
}

final dmExportControllerProvider = Provider<DmExportController>(
  (ref) => DmExportController(ref),
);

/// Runs [DmExportController.exportSelected] and, once it resolves, shows
/// [ExportCompleteDialog] with the result. Shared by every place that
/// offers an "export selected individuals" action (the home page's
/// overflow menu/FAB and the lineage tree's context menu) so they all go
/// through the exact same flow.
Future<void> exportSelectedDenpaMen(
  BuildContext context,
  WidgetRef ref,
  MasterData masterData,
) async {
  final t = context.t;
  final result = await ref
      .read(dmExportControllerProvider)
      .exportSelected(masterData, dialogTitle: t.home.exportDialogTitle);
  if (result != null && context.mounted) {
    await ExportCompleteDialog.show(context, result: result);
  }
}
