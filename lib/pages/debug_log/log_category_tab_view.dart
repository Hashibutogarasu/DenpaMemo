import 'package:flutter/material.dart';

import 'package:app_logging/app_logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Renders one [LogEntry] as a single row, using the same
/// `[datetime][thread][level] text` line the debug log screen's copy and
/// log-file output use.
class LogEntryTile extends StatelessWidget {
  const LogEntryTile({super.key, required this.entry});

  final LogEntry entry;

  @override
  Widget build(BuildContext context) {
    return ListTile(dense: true, title: Text(formatLogEntry(entry)));
  }
}

/// One tab of the debug log screen: the live entries for [category].
class LogCategoryTabView extends ConsumerWidget {
  const LogCategoryTabView({
    super.key,
    required this.category,
    required this.emptyLabel,
  });

  final LogCategory category;
  final String emptyLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = switch (category) {
      LogCategory.normal => ref.watch(normalLogProvider),
      LogCategory.widgetRebuild => ref.watch(widgetRebuildLogProvider),
      LogCategory.network => ref.watch(networkLogProvider),
    };
    if (entries.isEmpty) {
      return Center(child: Text(emptyLabel));
    }
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) => LogEntryTile(entry: entries[index]),
    );
  }
}
