import 'dart:convert';

/// File extension used by `.dm` backup files (without the leading dot).
const dmFileExtension = 'dm';

/// Encodes [dataVersion] as a `.dm` header string, embedded as the backup
/// zip's EOCD comment. Shared by `DMFile.encodeHeader` and the export step
/// that writes the zip (`WriteZipStep` in `dm_export_steps.dart`), which
/// can't import `dm_file.dart` directly without creating an import cycle
/// (`DMFile.writeExport` builds and runs the step list).
String encodeDmHeader(String dataVersion) => jsonEncode({'dataVersion': dataVersion});
