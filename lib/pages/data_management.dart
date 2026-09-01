import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/cache_file_providers.dart';
import '../providers/data_cleanup_providers.dart';

Future<bool> _confirm(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final t = context.t;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.common.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(t.common.confirm),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

Future<void> _cleanupApplicationFolder(
  BuildContext context,
  WidgetRef ref,
) async {
  final t = context.t;
  final confirmed = await _confirm(
    context,
    title: t.settings.dataManagementCleanupConfirmTitle,
    message: t.settings.dataManagementCleanupConfirmMessage,
  );
  if (!confirmed || !context.mounted) {
    return;
  }
  final removedCount = await ref
      .read(dataCleanupControllerProvider)
      .cleanupApplicationFolder();
  if (!context.mounted) {
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        t.settings.dataManagementCleanupResult(count: removedCount),
      ),
    ),
  );
}

Future<void> _clearCache(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final confirmed = await _confirm(
    context,
    title: t.settings.dataManagementClearCacheConfirmTitle,
    message: t.settings.dataManagementClearCacheConfirmMessage,
  );
  if (!confirmed || !context.mounted) {
    return;
  }
  await ref.read(dataCleanupControllerProvider).clearCache();
  ref.invalidate(cachedDataSizeProvider);
  if (!context.mounted) {
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(t.settings.dataManagementClearCacheResult)),
  );
}

/// Housekeeping actions for the account's on-disk data: removing orphaned
/// icon folders, and wiping the temporary/cache directory outright.
class DataManagementPage extends ConsumerWidget {
  const DataManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.dataManagement),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: Text(t.settings.dataManagementCleanupFolder),
            onTap: () => _cleanupApplicationFolder(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep_outlined),
            title: Text(t.settings.dataManagementClearCache),
            trailing: switch (ref.watch(cachedDataSizeProvider)) {
              AsyncData(:final value) => FileSizeText(bytes: value),
              _ => null,
            },
            onTap: () => _clearCache(context, ref),
          ),
        ],
      ),
    );
  }
}
