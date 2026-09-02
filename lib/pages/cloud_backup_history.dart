import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/cloud_backup_history_providers.dart';
import '../providers/cloud_files_providers.dart';
import '../widgets/dialog/cloud_file_action_menu.dart';
import '../widgets/dialog/confirm_dialog.dart';
import '../widgets/generic_selection_floating_menu.dart';
import '../widgets/list/list_item_container.dart';
import '../widgets/list/list_item_tile.dart';
import '../widgets/list/list_tile_section.dart';
import '../widgets/scaffold/cloud_backup_shell.dart';

Future<void> _deleteSelected(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final selectedIds = ref.read(selectedCloudFileIdsProvider);
  final confirmed = await ConfirmDialog.show(
    context,
    title: t.cloudBackup.deleteConfirmTitle,
    message: t.cloudBackup.deleteSelectedConfirmMessage,
  );
  if (!confirmed) return;
  await ref.read(cloudFilesProvider.notifier).deleteCloudFiles(selectedIds);
  ref.read(selectedCloudFileIdsProvider.notifier).state = {};
  ref.read(cloudFileSelectionModeProvider.notifier).state = false;
}

/// Settings → cloud backup history: every uploaded `.dm` backup across
/// every device on the account, grouped by upload date. Reuses the
/// generalized [ListItemTile]/[ListItemContainer]/[ListTileSection] from
/// the settings page and [GenericSelectionFloatingMenu] from the home
/// page's multi-select bar.
class CloudBackupHistoryPage extends ConsumerWidget {
  const CloudBackupHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    ref.watch(cloudFilesSyncProvider);

    final files = ref.watch(sortedCloudFilesProvider);
    final selectionMode = ref.watch(cloudFileSelectionModeProvider);
    final selectedIds = ref.watch(selectedCloudFileIdsProvider);
    final allSelected =
        files.isNotEmpty && files.every((file) => selectedIds.contains(file.fileId));
    final groups = groupBy(files, (CloudFile file) => file.uploadedAt.startOfDay);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.cloudBackupHistory),
      belowHeader: const CloudBackupProgressBar(),
      body: Stack(
        children: [
          SmoothScrollContainer(
            child: files.isEmpty
                ? Center(child: Text(t.cloudBackup.historyEmptyDescription))
                : ListView(
                    children: [
                      for (final entry in groups.entries) ...[
                        ListTileSection(title: entry.key.format(pattern: 'yyyy/MM/dd', locale: 'ja')),
                        ListItemContainer(
                          children: [
                            for (final file in entry.value)
                              ListItemTile(
                                icon: Icons.description_outlined,
                                label: file.filename,
                                trailingText: file.uploadedAt.format(pattern: 'HH:mm', locale: 'ja'),
                                selectionMode: selectionMode,
                                selected: selectedIds.contains(file.fileId),
                                onSelectedChanged: (_) => toggleCloudFileSelected(ref, file.fileId),
                                onLongPress: () {
                                  ref.read(cloudFileSelectionModeProvider.notifier).state = true;
                                  toggleCloudFileSelected(ref, file.fileId);
                                },
                                actionMenuItemsBuilder: (context) =>
                                    cloudFileActionMenuItems(context, ref, cloudFile: file),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GenericSelectionFloatingMenu(
                visible: selectionMode,
                allSelected: allSelected,
                onToggleSelectAll: () =>
                    ref.read(selectedCloudFileIdsProvider.notifier).state = allSelected
                    ? {}
                    : {for (final file in files) file.fileId},
                selectAllTooltip: t.home.selectAll,
                deselectAllTooltip: t.home.deselectAll,
                onCancel: () {
                  ref.read(selectedCloudFileIdsProvider.notifier).state = {};
                  ref.read(cloudFileSelectionModeProvider.notifier).state = false;
                },
                cancelTooltip: t.common.cancel,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.accent),
                    tooltip: t.common.delete,
                    onPressed: () => _deleteSelected(context, ref),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
