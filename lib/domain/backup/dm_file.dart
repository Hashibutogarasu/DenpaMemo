import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'dm_import_error.dart';

part 'dm_file.freezed.dart';

/// The `.dm` backup header, embedded as the zip archive's EOCD comment.
/// Holds only the app version (`PackageInfo.version`) that produced the
/// file. Import step 3 checks only that [dataVersion] is present and
/// readable as a string; it never compares it against the current app
/// version.
@freezed
abstract class DMFile with _$DMFile {
  const DMFile._();

  static const extension = 'dm';

  const factory DMFile({required String dataVersion}) = _DMFile;

  String encodeHeader() => jsonEncode({'dataVersion': dataVersion});

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
}
