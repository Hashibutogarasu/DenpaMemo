import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/dm_export_providers.dart';
import '../providers/dm_import_providers.dart';
import '../providers/home_view_providers.dart';
import '../providers/master_data_providers.dart';
import '../providers/responsive_providers.dart';
import '../theme/app_colors.dart';
import '../widgets/add_denpa_men_fab.dart';
import '../widgets/container/denpa_men_box.dart';
import '../widgets/denpa_men_accordion_tile.dart';
import '../widgets/denpa_men_lineage_tree.dart';
import '../widgets/denpa_men_list_tile.dart';
import '../widgets/dialog/denpa_men_preview_dialog.dart';
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
    final result = await ref
        .read(dmImportControllerProvider)
        .importFromFile(context);
    if (result != null && context.mounted) {
      await ImportCompleteDialog.show(context, result: result);
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
              const SingleActivator(
                LogicalKeyboardKey.keyA,
                control: true,
              ): () =>
                  _selectAll(masterData),
              const SingleActivator(LogicalKeyboardKey.escape): _clearSelection,
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
        data: (masterData) => Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 72 : 0),
          child: AddDenpaMenFab(
            masterData: masterData,
            onImport: isMobile ? () => _importFromFile(context, ref) : null,
            onExport: isMobile && selectedCount > 0
                ? () => _exportSelected(context, ref, masterData)
                : null,
          ),
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

    final contentPadding = EdgeInsets.fromLTRB(
      isMobile ? 0 : 16,
      0,
      isMobile ? 0 : 16,
      96,
    );

    return Column(
      children: [
        const SizedBox(height: 64),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: recordsAsync.when(
                  data: (records) {
                    if (records.isEmpty) {
                      return Center(child: Text(context.t.home.empty));
                    }
                    return switch (tileMode) {
                      HomeTileMode.grid => DenpaMenBox(
                        records: records,
                        selectionMode: selectionMode,
                        selectedIds: selectedIds,
                        cutIds: cutIds,
                        onSelectedChanged: (id, selected) =>
                            _setSelected(ref, id, selected),
                        onTapRecord: (denpaMen) => DenpaMenPreviewDialog.show(
                          context,
                          denpaMen: denpaMen,
                        ),
                        padding: contentPadding,
                      ),
                      HomeTileMode.tile => ListView.builder(
                        padding: contentPadding,
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          final record = records[index];
                          final denpaMen = record.denpaMen;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: isMobile
                                ? Opacity(
                                    opacity: cutIds.contains(record.id)
                                        ? 0.5
                                        : 1,
                                    child: DenpaMenListTile(
                                      denpaMen: denpaMen,
                                      selectionMode: selectionMode,
                                      selected: selectedIds.contains(record.id),
                                      onSelectedChanged: (selected) =>
                                          _setSelected(
                                            ref,
                                            record.id,
                                            selected,
                                          ),
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
                    };
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
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
          ),
        ),
      ],
    );
  }
}
