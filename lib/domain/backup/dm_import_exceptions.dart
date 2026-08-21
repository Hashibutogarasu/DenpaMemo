/// Thrown by a `.dm` import step when `entries.json` is missing, or its
/// contents are not a JSON array at all (as opposed to one malformed
/// element, see `DenpaMenEntryParseError`). Caught by the import
/// controller to show a plain "invalid file" message.
class DmInvalidImportFileException implements Exception {
  const DmInvalidImportFileException();
}

/// Thrown to unwind a `.dm` import the user backed out of partway through
/// (e.g. declining to resolve duplicate individuals). Caught by the
/// import controller, which then simply returns null with no error UI.
class DmImportCancelled implements Exception {
  const DmImportCancelled();
}
