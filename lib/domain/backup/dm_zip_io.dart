import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as path;

/// Streams every file under [sourceDirectory] into a zip file at
/// [outputFile], embedding [headerComment] as the archive's EOCD comment.
/// Reads each file from disk one at a time via [InputFileStream] rather
/// than loading [sourceDirectory]'s contents into memory up front.
Future<void> writeDmZip({
  required Directory sourceDirectory,
  required File outputFile,
  required String headerComment,
}) async {
  final encoder = ZipEncoder();
  final output = OutputFileStream(outputFile.path);
  encoder.startEncode(output);
  for (final entity in sourceDirectory.listSync(recursive: true)) {
    final relativePath = path.posix.fromUri(
      path.toUri(path.relative(entity.path, from: sourceDirectory.path)),
    );
    if (entity is Directory) {
      encoder.add(ArchiveFile.directory(relativePath));
    } else if (entity is File) {
      encoder.add(ArchiveFile.stream(relativePath, InputFileStream(entity.path)));
    }
  }
  encoder.endEncode(comment: headerComment);
  await output.close();
}

/// Result of [readDmZip]: the parsed header comment (raw string, still to
/// be passed through `DMFile.decodeHeader`) and the directory the zip's
/// contents were extracted into.
class DMZipReadResult {
  const DMZipReadResult({
    required this.headerComment,
    required this.extractedDirectory,
  });

  final String? headerComment;
  final Directory extractedDirectory;
}

/// Decodes [inputFile] as a zip archive, streaming it into
/// [outputDirectory] via [extractArchiveToDisk] rather than buffering the
/// whole archive as a single byte array.
Future<DMZipReadResult> readDmZip({
  required File inputFile,
  required Directory outputDirectory,
}) async {
  final decoder = ZipDecoder();
  final inputStream = InputFileStream(inputFile.path);
  final archive = decoder.decodeStream(inputStream);
  await extractArchiveToDisk(archive, outputDirectory.path);
  await inputStream.close();
  return DMZipReadResult(
    headerComment: decoder.directory.zipFileComment.isEmpty
        ? null
        : decoder.directory.zipFileComment,
    extractedDirectory: outputDirectory,
  );
}
