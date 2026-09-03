import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../../i18n/gen/strings.g.dart';
import '../../providers/denpa_men_icon_providers.dart';
import '../../providers/denpa_men_providers.dart';
import '../../providers/home_view_providers.dart';
import '../../providers/qr_code_providers.dart';
import '../../providers/search_providers.dart';
import '../denpa_men_lineage_tree.dart';
import '../dialog/denpa_men_action_menu.dart';
import '../selection_floating_menu.dart';

/// Full home-style screen: view mode toggles and the individual
/// list/grid/tree display. Takes [masterData] and [title] as properties
/// rather than loading master data itself, so callers (the home page and
/// the search results page) can reuse this exact screen for different
/// individual sets. [floatingActionButton] and [actions] are forwarded
/// straight to [AppScaffold] rather than built here, since the
/// add/import/export FAB and header menu are the home page's own concern.
class DenpaMenHomeScreen extends ConsumerStatefulWidget {
  const DenpaMenHomeScreen({
    super.key,
    required this.title,
    required this.masterData,
    this.floatingActionButton,
    this.floatingActionButtonExpansion,
    this.actions,
  });

  final Widget title;
  final MasterData masterData;
  final Widget? floatingActionButton;

  final ValueNotifier<bool>? floatingActionButtonExpansion;
  final List<Widget>? actions;

  @override
  ConsumerState<DenpaMenHomeScreen> createState() => _DenpaMenHomeScreenState();
}

class _DenpaMenHomeScreenState extends ConsumerState<DenpaMenHomeScreen> {
  final _lineageTreeController = GraphViewController();
  bool _treeCursorEnabled = false;

  void _selectAll() {
    final records = ref
        .read(denpaMenRepositoryProvider)
        .getAll(widget.masterData);
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
    final masterData = widget.masterData;
    ref.watch(denpaMenCatchOrderMigrationProvider(masterData));
    final t = context.t;
    final selectionMode = ref.watch(selectionModeProvider);
    final viewMode = ref.watch(homeViewModeProvider);
    final tileMode = ref.watch(homeTileModeProvider);
    final isMobile = ref.watch(appShellStateProvider).isMobile;

    final isLoading =
        ref.watch(denpaMenListProvider(masterData)).isLoading ||
        (viewMode == HomeViewMode.tree &&
            ref.watch(qrCodeListProvider).isLoading);
    final shellState = ref.read(appShellStateProvider);
    if (shellState.isLoading != isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ref
            .read(appShellStateProvider.notifier)
            .update(
              (state) => (isMobile: state.isMobile, isLoading: isLoading),
            );
      });
    }

    return AppScaffold(
      title: widget.title,
      additionalShortcuts: selectionMode
          ? {
              const SingleActivator(LogicalKeyboardKey.keyA, control: true):
                  _selectAll,
              const SingleActivator(LogicalKeyboardKey.escape): _clearSelection,
            }
          : const {},
      actions: widget.actions,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonExpansion: widget.floatingActionButtonExpansion,
      body: Stack(
        children: [
          Positioned.fill(
            child: switch (viewMode) {
              HomeViewMode.list => _HomeBody(masterData: masterData),
              HomeViewMode.tree => DenpaMenLineageTree(
                masterData: masterData,
                controller: _lineageTreeController,
                cursorEnabled: _treeCursorEnabled,
              ),
            },
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
          if (viewMode == HomeViewMode.tree) ...[
            Positioned(
              top: 64,
              right: 16,
              child: ElevatedButton.icon(
                onPressed: () => _lineageTreeController.zoomToFit(),
                icon: const Icon(Icons.center_focus_strong, size: 18),
                label: Text(t.home.resetTreePosition),
              ),
            ),
            if (isMobile) ...[
              Positioned(
                top: 112,
                right: 16,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      setState(() => _treeCursorEnabled = !_treeCursorEnabled),
                  icon: Icon(
                    _treeCursorEnabled ? Icons.add_circle : Icons.add,
                    size: 18,
                  ),
                  label: Text(t.home.toggleTreeCursor),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Scrollable accordion listing every individual matching the shared
/// search context (see [filteredDenpaMenProvider]) as a collapsed preview;
/// expanding an entry reveals its full [DenpaMenStatus] plus edit and
/// delete actions (see [DenpaMenAccordionTile]). When multi-select mode is
/// active, a [SelectionFloatingMenu] surfaces bulk actions for the current
/// selection.
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
    final records = ref.watch(filteredDenpaMenProvider(masterData));
    final selectionMode = ref.watch(selectionModeProvider);
    final selectedIds = ref.watch(selectedDenpaMenIdsProvider);
    final cutIds = ref.watch(cutDenpaMenIdsProvider);
    final isMobile = ref.watch(appShellStateProvider).isMobile;
    final tileMode = ref.watch(homeTileModeProvider);
    final totalAttributeCount = masterData.attributes.length;
    final iconsById = {
      for (final record in records)
        record.denpaMen.id: ref
            .watch(denpaMenIconProvider(record.denpaMen.id))
            .value,
    };

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
                child: SmoothScrollContainer(
                  child: recordsAsync.when(
                    data: (_) {
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
                            totalAttributeCount: totalAttributeCount,
                            iconFile: iconsById[denpaMen.id],
                          ),
                          iconsById: iconsById,
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
                                        selected: selectedIds.contains(
                                          record.id,
                                        ),
                                        onSelectedChanged: (selected) =>
                                            _setSelected(
                                              ref,
                                              record.id,
                                              selected,
                                            ),
                                        onTap: () => DenpaMenPreviewDialog.show(
                                          context,
                                          denpaMen: denpaMen,
                                          totalAttributeCount:
                                              totalAttributeCount,
                                          iconFile: iconsById[denpaMen.id],
                                        ),
                                        enableLongPressPreview: false,
                                        iconFile: iconsById[denpaMen.id],
                                        actionMenuItemsBuilder: (context) =>
                                            denpaMenActionMenuItems(
                                              context,
                                              ref,
                                              record: record,
                                              masterData: masterData,
                                            ),
                                      ),
                                    )
                                  : DenpaMenAccordionTile(
                                      denpaMen: denpaMen,
                                      totalAttributeCount: totalAttributeCount,
                                      selectionMode: selectionMode,
                                      selected: selectedIds.contains(record.id),
                                      isCut: cutIds.contains(record.id),
                                      onSelectedChanged: (selected) =>
                                          _setSelected(
                                            ref,
                                            record.id,
                                            selected,
                                          ),
                                      iconFile: iconsById[denpaMen.id],
                                      actionMenuItemsBuilder: (context) =>
                                          denpaMenActionMenuItems(
                                            context,
                                            ref,
                                            record: record,
                                            masterData: masterData,
                                          ),
                                    ),
                            );
                          },
                        ),
                      };
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (error, stackTrace) => Center(child: Text('$error')),
                  ),
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
