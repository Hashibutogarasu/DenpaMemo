/// Which of the debug log screen's three stores a [LogEntry] belongs to.
/// Also names the on-disk log file each category is written to by
/// [LogFileWriter].
enum LogCategory {
  normal,
  widgetRebuild,
  network;

  String get fileNameSegment => switch (this) {
    LogCategory.normal => 'normal',
    LogCategory.widgetRebuild => 'widgetRebuild',
    LogCategory.network => 'network',
  };
}
