import 'dart:io';

import 'package:app_logging/app_logging.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// The [LogFileWriter] started by [installLogFileWriter], so the debug log
/// screen can look up each category's file path. `null` until installed.
LogFileWriter? logFileWriter;

/// Starts writing every [LogBus] entry to `<app support dir>/logs/...` —
/// see [LogFileWriter] for the folder/file layout.
Future<void> installLogFileWriter() async {
  final supportDirectory = await getApplicationSupportDirectory();
  final writer = LogFileWriter(
    logsDirectory: Directory(p.join(supportDirectory.path, 'logs')),
  );
  await writer.start();
  logFileWriter = writer;
}
