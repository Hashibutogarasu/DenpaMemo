import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import 'package:denpa_memo/widgets.dart' hide Translations;
import '../../i18n/gen/strings.g.dart';
import '../../providers/denpa_men_icon_providers.dart';
import '../../providers/denpa_men_providers.dart';
import '../../providers/home_view_providers.dart';
import '../../providers/search_providers.dart';
import '../denpa_men_lineage_tree.dart';
import '../dialog/denpa_men_action_menu.dart';
import '../icon/denpa_men_icon.dart';
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
    final isMobile = ResponsiveScope.isMobileOf(context);

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

/// Number of records [_HomeBody] renders per page by default, before the
/// user scrolls to reveal more.
const int homeListDefaultPageSize = 10;

/// Scrollable accordion listing every individual matching the shared
/// search context (see [filteredDenpaMenProvider]) as a collapsed preview;
/// expanding an entry reveals its full [DenpaMenStatus] plus edit and
/// delete actions (see [DenpaMenAccordionTile]). When multi-select mode is
/// active, a [SelectionFloatingMenu] surfaces bulk actions for the current
/// selection.
///
/// Only [pageSize] records are built at a time; scrolling near the bottom
/// reveals [pageSize] more (see [_HomeBodyState._loadMore]), so a long
/// list doesn't force every entry's clipped thumbnail (see
/// `renderClippedImage`) to render up front.
class _HomeBody extends ConsumerStatefulWidget {
  const _HomeBody({
    required this.masterData,
    this.pageSize = homeListDefaultPageSize,
  });

  final MasterData masterData;
  final int pageSize;

  @override
  ConsumerState<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends ConsumerState<_HomeBody> {
  late int _visibleCount = widget.pageSize;

  /// The in-flight page reveal, if any — its own [FutureBuilder]
  /// connection state is the single source of truth for whether the
  /// "loading more" footer shows, instead of a separately maintained flag.
  Future<void>? _loadMoreFuture;

  void _setSelected(int id, bool selected) {
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

  void _resetPagination() {
    setState(() {
      _visibleCount = widget.pageSize;
      _loadMoreFuture = null;
    });
  }

  void _loadMore(int totalCount) {
    if (_loadMoreFuture != null || _visibleCount >= totalCount) return;
    setState(() {
      _loadMoreFuture = Future<void>.delayed(const Duration(milliseconds: 200))
          .then((_) {
            if (!mounted) return;
            setState(() {
              final next = _visibleCount + widget.pageSize;
              _visibleCount = next > totalCount ? totalCount : next;
              _loadMoreFuture = null;
            });
          });
    });
  }

  bool _onScrollMetricsChanged(ScrollMetrics metrics, int totalCount) {
    if (metrics.extentAfter < 300) {
      _loadMore(totalCount);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final masterData = widget.masterData;
    final recordsAsync = ref.watch(denpaMenListProvider(masterData));
    final records = ref.watch(filteredDenpaMenProvider(masterData));
    ref.listen(searchQueryProvider, (previous, next) => _resetPagination());

    final selectionMode = ref.watch(selectionModeProvider);
    final selectedIds = ref.watch(selectedDenpaMenIdsProvider);
    final cutIds = ref.watch(cutDenpaMenIdsProvider);
    final isMobile = ResponsiveScope.isMobileOf(context);
    final tileMode = ref.watch(homeTileModeProvider);
    final totalAttributeCount = masterData.attributes.length;

    final visibleRecords = records.take(_visibleCount).toList();
    final footer = _visibleCount < records.length
        ? FutureBuilder<void>(
            future: _loadMoreFuture,
            builder: (context, snapshot) => Visibility(
              visible: snapshot.connectionState == ConnectionState.waiting,
              child: const _HomeListLoadMoreIndicator(),
            ),
          )
        : const _HomeListEndMessage();

    return Column(
      children: [
        const SizedBox(height: 64),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: SmoothScrollContainer(
                  child: _HomeRecordList(
                    masterData: masterData,
                    recordsAsync: recordsAsync,
                    records: records,
                    visibleRecords: visibleRecords,
                    tileMode: tileMode,
                    isMobile: isMobile,
                    selectionMode: selectionMode,
                    selectedIds: selectedIds,
                    cutIds: cutIds,
                    totalAttributeCount: totalAttributeCount,
                    footer: footer,
                    onSetSelected: _setSelected,
                    onScrollMetricsChanged: _onScrollMetricsChanged,
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

/// Renders [visibleRecords] as a grid or list (per [tileMode]), resolving
/// each record's icon and zoom-candidate images itself. Split out of
/// [_HomeBodyState] so that an individual record's icon/image provider
/// resolving doesn't rebuild [_HomeBodyState]'s own subtree — most
/// importantly its sibling [SelectionFloatingMenu] — along with it.
class _HomeRecordList extends ConsumerWidget {
  const _HomeRecordList({
    required this.masterData,
    required this.recordsAsync,
    required this.records,
    required this.visibleRecords,
    required this.tileMode,
    required this.isMobile,
    required this.selectionMode,
    required this.selectedIds,
    required this.cutIds,
    required this.totalAttributeCount,
    required this.footer,
    required this.onSetSelected,
    required this.onScrollMetricsChanged,
  });

  final MasterData masterData;
  final AsyncValue<List<DenpaMenRecord>> recordsAsync;
  final List<DenpaMenRecord> records;
  final List<DenpaMenRecord> visibleRecords;
  final HomeTileMode tileMode;
  final bool isMobile;
  final bool selectionMode;
  final Set<int> selectedIds;
  final Set<int> cutIds;
  final int totalAttributeCount;
  final Widget? footer;
  final void Function(int id, bool selected) onSetSelected;
  final bool Function(ScrollMetrics metrics, int totalCount)
  onScrollMetricsChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentPadding = EdgeInsets.fromLTRB(
      isMobile ? 0 : 16,
      0,
      isMobile ? 0 : 16,
      96,
    );

    return recordsAsync.when(
      data: (_) {
        if (records.isEmpty) {
          return Center(child: Text(context.t.home.empty));
        }
        final content = switch (tileMode) {
          HomeTileMode.grid => DenpaMenBox(
            records: visibleRecords,
            cellBuilder: (context, record, cellSize) => _DenpaMenGridCell(
              record: record,
              selectionMode: selectionMode,
              selected: selectedIds.contains(record.id),
              cut: cutIds.contains(record.id),
              onSelectedChanged: (selected) =>
                  onSetSelected(record.id, selected),
              onTap: () => DenpaMenPreviewDialog.show(
                context,
                denpaMen: record.denpaMen,
                totalAttributeCount: totalAttributeCount,
                iconBuilder: (size) =>
                    DenpaMenIcon(denpaMenId: record.denpaMen.id, size: size),
              ),
              size: cellSize,
            ),
            padding: contentPadding,
            trailing: footer,
          ),
          HomeTileMode.tile => ListView.builder(
            padding: contentPadding,
            itemCount: visibleRecords.length + (footer != null ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= visibleRecords.length) {
                return footer!;
              }
              final record = visibleRecords[index];
              final denpaMen = record.denpaMen;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: isMobile
                    ? Opacity(
                        opacity: cutIds.contains(record.id) ? 0.5 : 1,
                        child: _DenpaMenListTileCell(
                          denpaMen: denpaMen,
                          selectionMode: selectionMode,
                          selected: selectedIds.contains(record.id),
                          onSelectedChanged: (selected) =>
                              onSetSelected(record.id, selected),
                          onTap: () => DenpaMenPreviewDialog.show(
                            context,
                            denpaMen: denpaMen,
                            totalAttributeCount: totalAttributeCount,
                            iconBuilder: (size) => DenpaMenIcon(
                              denpaMenId: denpaMen.id,
                              size: size,
                            ),
                          ),
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
                            onSetSelected(record.id, selected),
                        iconBuilder: (size) =>
                            DenpaMenIcon(denpaMenId: denpaMen.id, size: size),
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
        return NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) =>
              onScrollMetricsChanged(notification.metrics, records.length),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) =>
                onScrollMetricsChanged(notification.metrics, records.length),
            child: content,
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => Center(child: Text('$error')),
    );
  }
}

/// One [DenpaMenBox] grid cell: resolves [record]'s icon itself, so only
/// the records [DenpaMenBox]'s `SliverChildBuilderDelegate` actually
/// realizes near the viewport ever watch [denpaMenIconProvider], instead
/// of every paginated record watching it upfront in [_HomeRecordList].
/// Deliberately passes no [DenpaMenContainer.zoomCandidates]: the grid
/// cell's icon is a plain, non-zoomable display — tapping it opens
/// [DenpaMenPreviewDialog] instead (see [onTap]).
class _DenpaMenGridCell extends ConsumerWidget {
  const _DenpaMenGridCell({
    required this.record,
    required this.selectionMode,
    required this.selected,
    required this.cut,
    required this.onSelectedChanged,
    required this.onTap,
    required this.size,
  });

  final DenpaMenRecord record;
  final bool selectionMode;
  final bool selected;
  final bool cut;
  final ValueChanged<bool> onSelectedChanged;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconFile = ref.watch(denpaMenIconProvider(record.denpaMen.id)).value;
    return Opacity(
      opacity: cut ? 0.5 : 1,
      child: DenpaMenContainer(
        denpaMen: record.denpaMen,
        selectionMode: selectionMode,
        selected: selected,
        onSelectedChanged: onSelectedChanged,
        onTap: onTap,
        enableLongPressPreview: false,
        iconFile: iconFile,
        size: size,
      ),
    );
  }
}

/// One [HomeTileMode.tile] mobile row: resolves [denpaMen]'s icon itself,
/// for the same reason as [_DenpaMenGridCell].
class _DenpaMenListTileCell extends ConsumerWidget {
  const _DenpaMenListTileCell({
    required this.denpaMen,
    required this.selectionMode,
    required this.selected,
    required this.onSelectedChanged,
    required this.onTap,
    required this.actionMenuItemsBuilder,
  });

  final DenpaMen denpaMen;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool> onSelectedChanged;
  final VoidCallback onTap;
  final List<PopupMenuEntry<VoidCallback>> Function(BuildContext)
  actionMenuItemsBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconFile = ref.watch(denpaMenIconProvider(denpaMen.id)).value;
    return DenpaMenListTile(
      denpaMen: denpaMen,
      selectionMode: selectionMode,
      selected: selected,
      onSelectedChanged: onSelectedChanged,
      onTap: onTap,
      enableLongPressPreview: false,
      iconFile: iconFile,
      actionMenuItemsBuilder: actionMenuItemsBuilder,
    );
  }
}

/// Trailing list/grid item shown while [_HomeBodyState._loadMore] is
/// fetching the next page.
class _HomeListLoadMoreIndicator extends StatelessWidget {
  const _HomeListLoadMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}

/// Trailing list/grid item shown once every record has been paged in.
class _HomeListEndMessage extends StatelessWidget {
  const _HomeListEndMessage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          context.t.home.reachedListEnd,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
