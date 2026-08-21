import 'dart:convert';

import '../backup/dm_import_error.dart';
import 'denpa_men_backup_entry.dart';

List<Map<String, dynamic>> encodeDenpaMenBackup(List<DenpaMenBackupEntry> entries) =>
    [for (final entry in entries) entry.toJson()];

/// Result of [decodeDenpaMenBackup]: every array element that parsed
/// successfully, and every [DenpaMenEntryParseError] caught along the way.
class DenpaMenBackupDecodeResult {
  const DenpaMenBackupDecodeResult({required this.entries, required this.failed});

  final List<DenpaMenBackupEntry> entries;
  final List<DenpaMenEntryParseError> failed;
}

/// Parses [source] as a JSON array of backup entries, one element at a
/// time. Unlike a whole-array decode, a single malformed element does not
/// discard the rest: parsing that element throws a
/// [DenpaMenEntryParseError], which is caught here and appended to
/// [DenpaMenBackupDecodeResult.failed] so the batch can continue with the
/// next element. Returns null only if [source] itself is not valid JSON or
/// is not a JSON array; those are structural failures of the whole file,
/// not of one entry, so callers should treat them as an invalid file.
DenpaMenBackupDecodeResult? decodeDenpaMenBackup(String source) {
  final Object? decoded;
  try {
    decoded = jsonDecode(source);
  } catch (_) {
    return null;
  }
  if (decoded is! List) {
    return null;
  }

  final entries = <DenpaMenBackupEntry>[];
  final failed = <DenpaMenEntryParseError>[];
  for (var index = 0; index < decoded.length; index++) {
    final item = decoded[index];
    try {
      if (item is! Map<String, dynamic>) {
        throw DenpaMenEntryParseError(index: index, rawEntry: item);
      }
      entries.add(DenpaMenBackupEntry.fromJson(item));
    } on DenpaMenEntryParseError catch (error) {
      failed.add(error);
    } catch (_) {
      failed.add(DenpaMenEntryParseError(index: index, rawEntry: item));
    }
  }
  return DenpaMenBackupDecodeResult(entries: entries, failed: failed);
}
