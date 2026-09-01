import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/cache_file_providers.dart';
import '../providers/data_cleanup_providers.dart';
import '../routing/app_router.dart';
import '../widgets/restart_widget.dart';

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

Future<void> _notify(
  BuildContext context, {
  required String title,
  required String message,
}) {
  final t = context.t;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.ok),
        ),
      ],
    ),
  );
}

/// Wipes every file under the account's app directory and every ObjectBox
/// box that holds user data, then navigates back to the home route and
/// forces a full rebuild of the app — including a fresh `ProviderScope`,
/// so every provider's cached state is dropped along with the data it
/// described — rather than leaving stale in-memory state behind.
Future<void> _deleteAllAppData(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final confirmed = await _confirm(
    context,
    title: t.settings.dataManagementDeleteAllDataConfirmTitle,
    message: t.settings.dataManagementDeleteAllDataConfirmMessage,
  );
  if (!confirmed || !context.mounted) {
    return;
  }
  await ref.read(dataCleanupControllerProvider).deleteAllAppData();
  if (!context.mounted) {
    return;
  }
  await _notify(
    context,
    title: t.settings.dataManagementResultTitle,
    message: t.settings.dataManagementDeleteAllDataResult,
  );
  if (!context.mounted) {
    return;
  }
  const HomeRoute().go(context);
  RestartWidget.restartApp(context);
}

/// Wipes the temp/cache directory and the offline data cache, then forces
/// a full rebuild of the app (see [_deleteAllAppData]) so the size shown
/// on this page — and every provider that read from either cache — starts
/// from zero again instead of from stale in-memory state.
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
  if (!context.mounted) {
    return;
  }
  await _notify(
    context,
    title: t.settings.dataManagementResultTitle,
    message: t.settings.dataManagementClearCacheResult,
  );
  if (!context.mounted) {
    return;
  }
  RestartWidget.restartApp(context);
}

/// Housekeeping actions for the account's on-disk data: wiping the app's
/// persistent data (files and ObjectBox records) outright, and wiping the
/// temporary/cache directory.
class DataManagementPage extends ConsumerWidget {
  const DataManagementPage({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    await Future.wait([
      ref.refresh(applicationFolderSizeProvider.future),
      ref.refresh(cachedDataSizeProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.dataManagement),
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            ListTile(
              leading: const Icon(Icons.delete_forever_outlined),
              title: Text(t.settings.dataManagementDeleteAllData),
              trailing: switch (ref.watch(applicationFolderSizeProvider)) {
                AsyncData(:final value) => FileSizeText(bytes: value),
                _ => null,
              },
              onTap: () => _deleteAllAppData(context, ref),
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
      ),
    );
  }
}
