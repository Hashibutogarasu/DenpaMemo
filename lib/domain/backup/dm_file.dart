import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../denpa_men/denpa_men.dart';
import '../master_data/master_data.dart';
import '../qr_code/qr_code.dart';
import 'dm_export_context.dart';
import 'dm_export_step.dart';
import 'dm_export_step_runner.dart';
import 'dm_export_steps.dart';
import 'dm_header_codec.dart';
import 'dm_import_error.dart';
import 'export_result.dart';

part 'dm_file.freezed.dart';

/// The `.dm` backup header, embedded as the zip archive's EOCD comment.
/// Holds only the app version (`PackageInfo.version`) that produced the
/// file. Import step 3 checks only that [dataVersion] is present and
/// readable as a string; it never compares it against the current app
/// version.
@freezed
abstract class DMFile with _$DMFile {
  const DMFile._();

  static const extension = dmFileExtension;

  const factory DMFile({required String dataVersion}) = _DMFile;

  String encodeHeader() => encodeDmHeader(dataVersion);

  /// Parses [comment] as a `.dm` header. Throws [DmHeaderReadError] if
  /// [comment] is empty, not valid JSON, or lacks a string `dataVersion`.
  static DMFile decodeHeader(String? comment) {
    if (comment == null || comment.isEmpty) {
      throw const DmHeaderReadError();
    }
    try {
      final decoded = jsonDecode(comment);
      if (decoded is! Map<String, dynamic>) {
        throw const DmHeaderReadError();
      }
      final dataVersion = decoded['dataVersion'];
      if (dataVersion is! String) {
        throw const DmHeaderReadError();
      }
      return DMFile(dataVersion: dataVersion);
    } on DmHeaderReadError {
      rethrow;
    } catch (_) {
      throw const DmHeaderReadError();
    }
  }

  /// Default `.dm` save-dialog file name: the export timestamp followed by
  /// the number of individuals it contains, e.g. `20260821_153042_5.dm`.
  static String defaultExportFileName({
    required DateTime exportedAt,
    required int individualCount,
  }) {
    String pad(int value, [int width = 2]) => value.toString().padLeft(width, '0');
    final timestamp =
        '${exportedAt.year}${pad(exportedAt.month)}${pad(exportedAt.day)}'
        '_${pad(exportedAt.hour)}${pad(exportedAt.minute)}${pad(exportedAt.second)}';
    return '${timestamp}_$individualCount.$extension';
  }

  /// Filters [candidates] down to those consistent with [masterData],
  /// packages them (with their linked [qrCodes]) into a `.dm` zip at
  /// [savePath], and returns the resulting [ExportResult].
  ///
  /// [loadIcon] is called once per exported individual to fetch its icon
  /// file (if any) for inclusion in the archive. [onProgress] is invoked
  /// with a 0-1 fraction as the export proceeds, and with `null` once it
  /// finishes.
  static Future<ExportResult> writeExport({
    required List<DenpaMen> candidates,
    required MasterData masterData,
    required List<QrCode> qrCodes,
    required Future<File?> Function(String denpaMenId) loadIcon,
    required String savePath,
    required String dataVersion,
    required void Function(double? progress) onProgress,
  }) async {
    final context = DmExportContext(
      candidates: candidates,
      masterData: masterData,
      qrCodes: qrCodes,
      loadIcon: loadIcon,
      savePath: savePath,
      dataVersion: dataVersion,
      onProgress: onProgress,
    );
    final steps = <DmExportStep>[
      FilterConsistentIndividualsStep(),
      CreateWorkDirectoryStep(),
      WriteEntriesJsonStep(),
      CopyIconsStep(),
      WriteZipStep(),
      CopyToSavePathStep(),
    ];
    await steps.runAll(context);
    return context.exportResult!;
  }
}
