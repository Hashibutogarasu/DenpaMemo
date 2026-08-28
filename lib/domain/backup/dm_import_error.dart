import '../../errors/app_error.dart';
import '../../i18n/gen/strings.g.dart';

/// Base type for every error that can interrupt a `.dm` import.
abstract class DmImportError extends AppError {
  const DmImportError();
}

/// Thrown when reading `.dm`'s zip header comment fails: the comment is
/// missing, not valid JSON, or lacks a string `dataVersion`.
class DmHeaderReadError extends DmImportError {
  const DmHeaderReadError();

  @override
  String title(Translations t) => t.backup.importHeaderErrorTitle;

  @override
  String description(Translations t) => t.backup.importHeaderErrorDescription;
}

/// Thrown when one element of `entries.json` fails to parse or validate
/// as a `DenpaMenBackupEntry`. [index] is the element's position in the
/// source array; [rawEntry] preserves whatever JSON value was there
/// (possibly not even a JSON object) so the completion dialog can still
/// show something identifying.
class DenpaMenEntryParseError extends DmImportError {
  const DenpaMenEntryParseError({required this.index, required this.rawEntry});

  final int index;
  final Object? rawEntry;

  @override
  String title(Translations t) => t.backup.importEntryParseErrorTitle;

  @override
  String description(Translations t) {
    final raw = rawEntry;
    if (raw is Map<String, dynamic>) {
      final denpaMen = raw['denpaMen'];
      if (denpaMen is Map<String, dynamic>) {
        final name = denpaMen['name'];
        if (name is String) {
          return t.backup.importEntryParseErrorDescriptionNamed(name: name);
        }
      }
    }
    return t.backup.importEntryParseErrorDescriptionIndexed(index: index + 1);
  }
}
