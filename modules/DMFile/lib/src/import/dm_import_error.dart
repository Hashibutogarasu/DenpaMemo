/// Thrown when reading `.dm`'s zip header comment fails: the comment is
/// missing, not valid JSON, or lacks a string `dataVersion`.
class DmHeaderReadError extends FormatException {
  const DmHeaderReadError() : super('Invalid or missing .dm header comment');
}

/// Thrown when one element of `entries.json` fails to parse or validate
/// as a `DenpaMenBackupEntry`. [index] is the element's position in the
/// source array; the raw JSON value is kept in [FormatException.source].
class DenpaMenEntryParseError extends FormatException {
  const DenpaMenEntryParseError({required this.index, Object? rawEntry})
    : super('Failed to parse denpa men backup entry at index $index', rawEntry);

  final int index;

  Object? get rawEntry => source;

  String? get entryName {
    final raw = rawEntry;
    if (raw is Map<String, dynamic>) {
      final denpaMen = raw['denpaMen'];
      if (denpaMen is Map<String, dynamic>) {
        final name = denpaMen['name'];
        if (name is String) return name;
      }
    }
    return null;
  }
}
