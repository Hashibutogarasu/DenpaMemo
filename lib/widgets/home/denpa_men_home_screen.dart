import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../../i18n/gen/strings.g.dart';
import '../../providers/clipping_slot_providers.dart';
import '../../providers/denpa_men_icon_providers.dart';
import '../../providers/denpa_men_providers.dart';
import '../../providers/entity_image_providers.dart';
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
  bool _isLoadingMore = false;

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
      _isLoadingMore = false;
    });
  }

  Future<void> _loadMore(int totalCount) async {
    if (_isLoadingMore || _visibleCount >= totalCount) return;
    setState(() => _isLoadingMore = true);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    setState(() {
      final next = _visibleCount + widget.pageSize;
      _visibleCount = next > totalCount ? totalCount : next;
      _isLoadingMore = false;
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
    final isMobile = ref.watch(appShellStateProvider).isMobile;
    final tileMode = ref.watch(homeTileModeProvider);
    final totalAttributeCount = masterData.attributes.length;

    final visibleRecords = records.take(_visibleCount).toList();
    final hasMore = _visibleCount < records.length;
    final footer = _isLoadingMore
        ? const _HomeListLoadMoreIndicator()
        : (hasMore ? null : const _HomeListEndMessage());

    final iconsById = {
      for (final record in visibleRecords)
        record.denpaMen.id: ref
            .watch(denpaMenIconProvider(record.denpaMen.id))
            .value,
    };
    final slotPriorityOrder = ref
        .watch(clippingSlotTypesByPriorityProvider)
        .value;
    final zoomCandidatesById = {
      for (final record in visibleRecords)
        record.denpaMen.id: [
          for (final slotType in DenpaMenImageSlotType.values)
            if (ref
                    .watch(
                      entityImageProvider((
                        denpaMenIconCategory,
                        record.denpaMen.id,
                        slotType,
                      )),
                    )
                    .value
                case final file?)
              (
                priority:
                    slotPriorityOrder?.indexOf(slotType) ??
                    DenpaMenImageSlotType.defaultPriority[slotType]!,
                file: file,
                label: _slotLabel(context.t, slotType),
              ),
        ],
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
                      final content = switch (tileMode) {
                        HomeTileMode.grid => DenpaMenBox(
                          records: visibleRecords,
                          selectionMode: selectionMode,
                          selectedIds: selectedIds,
                          cutIds: cutIds,
                          onSelectedChanged: (id, selected) =>
                              _setSelected(id, selected),
                          onTapRecord: (denpaMen) => DenpaMenPreviewDialog.show(
                            context,
                            denpaMen: denpaMen,
                            totalAttributeCount: totalAttributeCount,
                            iconFile: iconsById[denpaMen.id],
                            zoomCandidates: zoomCandidatesById[denpaMen.id],
                          ),
                          iconsById: iconsById,
                          zoomCandidatesById: zoomCandidatesById,
                          padding: contentPadding,
                          trailing: footer,
                        ),
                        HomeTileMode.tile => ListView.builder(
                          padding: contentPadding,
                          itemCount:
                              visibleRecords.length + (footer != null ? 1 : 0),
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
                                            _setSelected(record.id, selected),
                                        onTap: () => DenpaMenPreviewDialog.show(
                                          context,
                                          denpaMen: denpaMen,
                                          totalAttributeCount:
                                              totalAttributeCount,
                                          iconFile: iconsById[denpaMen.id],
                                          zoomCandidates:
                                              zoomCandidatesById[denpaMen.id],
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
                                          _setSelected(record.id, selected),
                                      iconFile: iconsById[denpaMen.id],
                                      zoomCandidates:
                                          zoomCandidatesById[denpaMen.id],
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
                            _onScrollMetricsChanged(
                              notification.metrics,
                              records.length,
                            ),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) =>
                              _onScrollMetricsChanged(
                                notification.metrics,
                                records.length,
                              ),
                          child: content,
                        ),
                      );
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

String _slotLabel(Translations t, DenpaMenImageSlotType slotType) {
  switch (slotType) {
    case DenpaMenImageSlotType.face:
      return t.settings.clippingFace;
    case DenpaMenImageSlotType.wholeBody:
      return t.settings.clippingWholeBody;
    case DenpaMenImageSlotType.icon:
      return t.settings.clippingIcon;
  }
}
