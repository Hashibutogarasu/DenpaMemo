import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../domain/backup/dm_duplicate_detection.dart';
import '../domain/backup/dm_file.dart';
import '../domain/backup/dm_import_error.dart';
import '../domain/backup/dm_zip_io.dart';
import '../domain/backup/import_result.dart';
import '../domain/backup/import_result_builder.dart';
import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_backup_codec.dart';
import '../domain/denpa_men/denpa_men_backup_merge.dart';
import '../domain/master_data/master_data.dart';
import '../domain/step_progress.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_icon_providers.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/dm_export_providers.dart';
import '../providers/home_view_providers.dart';
import '../providers/import_export_progress_providers.dart';
import '../providers/master_data_providers.dart';
import '../providers/qr_code_providers.dart';
import '../providers/responsive_providers.dart';
import '../theme/app_colors.dart';
import '../widgets/add_denpa_men_fab.dart';
import '../widgets/container/denpa_men_box.dart';
import '../widgets/denpa_men_accordion_tile.dart';
import '../widgets/denpa_men_lineage_tree.dart';
import '../widgets/denpa_men_list_tile.dart';
import '../widgets/dialog/denpa_men_preview_dialog.dart';
import '../widgets/dialog/denpa_men_selection_dialog.dart';
import '../widgets/dialog/error_dialog.dart';
import '../widgets/dialog/export_complete_dialog.dart';
import '../widgets/dialog/import_complete_dialog.dart';
import '../widgets/home/toggle_button_group.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';
import '../widgets/selection_floating_menu.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final _lineageTreeController = GraphViewController();

  Future<void> _exportSelected(
    BuildContext context,
    WidgetRef ref,
    MasterData masterData,
  ) async {
    final t = context.t;
    final result = await ref
        .read(dmExportControllerProvider)
        .exportSelected(masterData, dialogTitle: t.home.exportDialogTitle);
    if (result != null && context.mounted) {
      await ExportCompleteDialog.show(context, result: result);
    }
  }

  Future<void> _importFromFile(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    const totalSteps = 11;
    final progress = ref.read(importExportProgressProvider.notifier);
    late final ImportResult importResult;

    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: [DMFile.extension],
    );
    final pickedPath = result?.files.single.path;
    if (pickedPath == null) {
      return;
    }

    progress.state = stepProgress(1, totalSteps);
    final tempRoot = await getTemporaryDirectory();
    final extractDirectory = Directory(
      path.join(tempRoot.path, 'dm_import_${DateTime.now().microsecondsSinceEpoch}'),
    );

    try {
      final readResult = await readDmZip(
        inputFile: File(pickedPath),
        outputDirectory: extractDirectory,
      );
      progress.state = stepProgress(4, totalSteps);

      try {
        DMFile.decodeHeader(readResult.headerComment);
      } on DmImportError catch (error) {
        if (context.mounted) {
          await ErrorDialog.show(context, error: error);
        }
        return;
      }
      progress.state = stepProgress(3, totalSteps);

      final entriesFile = File(path.join(extractDirectory.path, 'entries.json'));
      if (!await entriesFile.exists()) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.home.importInvalidFile)));
        }
        return;
      }
      final decodeResult = decodeDenpaMenBackup(await entriesFile.readAsString());
      if (decodeResult == null ||
          (decodeResult.entries.isEmpty && decodeResult.failed.isEmpty)) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.home.importInvalidFile)));
        }
        return;
      }
      final entries = decodeResult.entries;
      final failedEntries = decodeResult.failed;
      progress.state = stepProgress(5, totalSteps);

      final iconsByDenpaMenId = <String, File>{};
      for (final entry in entries) {
        final iconDirectory = Directory(
          path.join(extractDirectory.path, 'icons', 'denpamens', entry.denpaMen.id),
        );
        final metadataFile = File(path.join(iconDirectory.path, 'metadata.json'));
        if (await metadataFile.exists()) {
          final metadata =
              jsonDecode(await metadataFile.readAsString()) as Map<String, dynamic>;
          final fileName = metadata['fileName'] as String?;
          if (fileName != null) {
            final iconFile = File(path.join(iconDirectory.path, fileName));
            if (await iconFile.exists()) {
              iconsByDenpaMenId[entry.denpaMen.id] = iconFile;
            }
          }
        }
      }
      progress.state = stepProgress(6, totalSteps);

      if (!context.mounted) {
        return;
      }
      final masterData = ref.read(masterDataProvider).value;
      if (masterData == null) {
        return;
      }
      final denpaMenRepository = ref.read(denpaMenRepositoryProvider);

      final candidates = [for (final e in entries) e.denpaMen];
      final List<DenpaMen> toImport;
      if (hasAnyDuplicateDenpaMen(candidates, denpaMenRepository, masterData)) {
        final selected = await DenpaMenSelectionDialog.show(
          context,
          title: t.home.importMergeConfirmTitle,
          candidates: candidates,
          initial: candidates,
        );
        if (selected == null || selected.isEmpty) {
          return;
        }
        toImport = selected;
      } else {
        toImport = candidates;
      }
      progress.state = stepProgress(8, totalSteps);

      final toImportIds = {for (final d in toImport) d.id};
      final selectedEntries = [
        for (final e in entries)
          if (toImportIds.contains(e.denpaMen.id)) e,
      ];

      final qrCodeRepository = ref.read(qrCodeRepositoryProvider);
      final mergeResults = <DenpaMenMergeResult>[];
      for (var i = 0; i < selectedEntries.length; i++) {
        mergeResults.addAll(
          mergeDenpaMenBackupEntries(
            [selectedEntries[i]],
            denpaMenRepository: denpaMenRepository,
            qrCodeRepository: qrCodeRepository,
            masterData: masterData,
          ),
        );
        progress.state = stepProgressWithinEntries(
          9,
          totalSteps,
          i,
          selectedEntries.length,
        );
      }

      final storage = ref.read(denpaMenIconStorageProvider);
      for (final entry in selectedEntries) {
        final iconFile = iconsByDenpaMenId[entry.denpaMen.id];
        if (iconFile != null) {
          await storage.saveIcon(entry.denpaMen.id, iconFile);
          ref.invalidate(denpaMenIconProvider(entry.denpaMen.id));
        }
      }

      for (final entry in selectedEntries) {
        final record = denpaMenRepository.findByCuid(entry.denpaMen.id, masterData);
        if (record == null) {
          continue;
        }
        final expectsIcon = iconsByDenpaMenId.containsKey(entry.denpaMen.id);
        if (expectsIcon) {
          await storage.loadIcon(entry.denpaMen.id);
        }
      }
      progress.state = stepProgress(10, totalSteps);

      importResult = buildImportResult(
        mergeResults,
        failedEntries,
        repository: denpaMenRepository,
        masterData: masterData,
      );
    } finally {
      if (await extractDirectory.exists()) {
        await extractDirectory.delete(recursive: true);
      }
      progress.state = null;
    }

    if (context.mounted) {
      await ImportCompleteDialog.show(context, result: importResult);
    }
  }

  void _selectAll(MasterData masterData) {
    final records = ref.read(denpaMenRepositoryProvider).getAll(masterData);
    ref.read(selectedDenpaMenIdsProvider.notifier).state = {
      for (final record in records) record.id,
    };
  }

  void _clearSelection() {
    ref.read(selectedDenpaMenIdsProvider.notifier).state = {};
    ref.read(selectionModeProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final masterDataAsync = ref.watch(masterDataProvider);
    final t = context.t;
    final selectedCount = ref.watch(selectedDenpaMenIdsProvider).length;
    final masterData = masterDataAsync.value;
    final isMobile = ref.watch(isMobileLayoutProvider);
    final selectionMode = ref.watch(selectionModeProvider);
    final viewMode = ref.watch(homeViewModeProvider);
    final tileMode = ref.watch(homeTileModeProvider);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.home),
      additionalShortcuts: selectionMode && masterData != null
          ? {
              const SingleActivator(LogicalKeyboardKey.keyA, control: true):
                  () => _selectAll(masterData),
              const SingleActivator(LogicalKeyboardKey.escape):
                  _clearSelection,
            }
          : const {},
      actions: isMobile
          ? null
          : [
              PopupMenuButton<void>(
                icon: const Icon(Icons.more_vert, color: AppColors.accent),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: selectedCount > 0,
                    onTap: masterData == null
                        ? null
                        : () => _exportSelected(context, ref, masterData),
                    child: Text(t.home.exportSelected),
                  ),
                  PopupMenuItem(
                    onTap: masterData == null
                        ? null
                        : () => _importFromFile(context, ref),
                    child: Text(t.home.importFromFile),
                  ),
                ],
              ),
            ],
      body: Stack(
        children: [
          Positioned.fill(
            child: masterDataAsync.when(
              data: (masterData) => switch (viewMode) {
                HomeViewMode.list => _HomeBody(masterData: masterData),
                HomeViewMode.tree => DenpaMenLineageTree(
                  masterData: masterData,
                  controller: _lineageTreeController,
                ),
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('$error')),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (viewMode == HomeViewMode.list) ...[
                  ToggleButtonGroup<HomeTileMode>(
                    values: HomeTileMode.values,
                    selected: tileMode,
                    onChanged: (mode) =>
                        ref.read(homeTileModeProvider.notifier).state = mode,
                    children: [
                      Tooltip(
                        message: t.home.viewModeTile,
                        child: const Icon(Icons.view_agenda, size: 20),
                      ),
                      Tooltip(
                        message: t.home.viewModeGrid,
                        child: const Icon(Icons.grid_view, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                ],
                ToggleButtonGroup<HomeViewMode>(
                  values: HomeViewMode.values,
                  selected: viewMode,
                  onChanged: (mode) =>
                      ref.read(homeViewModeProvider.notifier).state = mode,
                  children: [
                    Tooltip(
                      message: t.home.viewModeList,
                      child: const Icon(Icons.view_list, size: 20),
                    ),
                    Tooltip(
                      message: t.home.viewModeTree,
                      child: const Icon(Icons.account_tree, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (viewMode == HomeViewMode.tree)
            Positioned(
              top: 64,
              right: 16,
              child: ElevatedButton.icon(
                onPressed: () => _lineageTreeController.zoomToFit(),
                icon: const Icon(Icons.center_focus_strong, size: 18),
                label: Text(t.home.resetTreePosition),
              ),
            ),
        ],
      ),
      floatingActionButton: masterDataAsync.maybeWhen(
        data: (masterData) => AddDenpaMenFab(
          masterData: masterData,
          onImport: isMobile ? () => _importFromFile(context, ref) : null,
          onExport: isMobile && selectedCount > 0
              ? () => _exportSelected(context, ref, masterData)
              : null,
        ),
        orElse: () => null,
      ),
    );
  }
}

/// Scrollable accordion listing every saved [DenpaMen] as a collapsed
/// preview; expanding an entry reveals its full [DenpaMenStatus] plus edit
/// and delete actions (see [DenpaMenAccordionTile]). When multi-select mode
/// is active, a [SelectionFloatingMenu] surfaces bulk actions for the
/// current selection.
class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.masterData});

  final MasterData masterData;

  void _setSelected(WidgetRef ref, int id, bool selected) {
    final ids = Set<int>.from(ref.read(selectedDenpaMenIdsProvider));
    if (selected) {
      ids.add(id);
    } else {
      ids.remove(id);
    }
    ref.read(selectedDenpaMenIdsProvider.notifier).state = ids;
    if (ids.isNotEmpty) {
      ref.read(selectionModeProvider.notifier).state = true;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(denpaMenListProvider(masterData));
    final selectionMode = ref.watch(selectionModeProvider);
    final selectedIds = ref.watch(selectedDenpaMenIdsProvider);
    final cutIds = ref.watch(cutDenpaMenIdsProvider);
    final isMobile = ref.watch(isMobileLayoutProvider);
    final tileMode = ref.watch(homeTileModeProvider);

    return Stack(
      children: [
        Positioned.fill(
          child: recordsAsync.when(
            data: (records) {
              if (records.isEmpty) {
                return Center(child: Text(context.t.home.empty));
              }
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  isMobile ? 0 : 16,
                  64,
                  isMobile ? 0 : 16,
                  96,
                ),
                child: switch (tileMode) {
                  HomeTileMode.grid => DenpaMenBox(
                    records: records,
                    selectionMode: selectionMode,
                    selectedIds: selectedIds,
                    cutIds: cutIds,
                    onSelectedChanged: (id, selected) =>
                        _setSelected(ref, id, selected),
                    onTapRecord: (denpaMen) =>
                        DenpaMenPreviewDialog.show(context, denpaMen: denpaMen),
                  ),
                  HomeTileMode.tile => ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      final denpaMen = record.denpaMen;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: isMobile
                            ? Opacity(
                                opacity: cutIds.contains(record.id) ? 0.5 : 1,
                                child: DenpaMenListTile(
                                  denpaMen: denpaMen,
                                  selectionMode: selectionMode,
                                  selected: selectedIds.contains(record.id),
                                  onSelectedChanged: (selected) =>
                                      _setSelected(ref, record.id, selected),
                                  onTap: () => DenpaMenPreviewDialog.show(
                                    context,
                                    denpaMen: denpaMen,
                                  ),
                                  enableLongPressPreview: false,
                                  record: record,
                                  masterData: masterData,
                                ),
                              )
                            : DenpaMenAccordionTile(
                                record: record,
                                masterData: masterData,
                                selectionMode: selectionMode,
                                selected: selectedIds.contains(record.id),
                                isCut: cutIds.contains(record.id),
                                onSelectedChanged: (selected) =>
                                    _setSelected(ref, record.id, selected),
                              ),
                      );
                    },
                  ),
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('$error')),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SelectionFloatingMenu(masterData: masterData),
            ),
          ),
        ),
      ],
    );
  }
}
