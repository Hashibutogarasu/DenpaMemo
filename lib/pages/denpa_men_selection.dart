import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/denpa_men_selection_providers.dart';
import '../providers/search_providers.dart';
import '../routing/app_router.dart';
import '../widgets/denpa_men_list_tile.dart';
import '../widgets/dialog/master_data_error_listener.dart';
import '../widgets/scaffold/app_scaffold.dart';
import '../widgets/search/search_form.dart';
import 'package:graphql_client/graphql_client.dart';

class DenpaMenSelectionArgs {
  const DenpaMenSelectionArgs({
    required this.excludeId,
    required this.initialSelectedIds,
    required this.maxSelectable,
  });

  final String excludeId;
  final List<String> initialSelectedIds;
  final int maxSelectable;
}

/// Full-page replacement for the old parent-picker dialog: lets the caller
/// choose up to [DenpaMenSelectionArgs.maxSelectable] individuals from
/// either the plain candidate list (tab 1) or a filtered search (tab 2,
/// which hands off to [DenpaMenSelectionSearchResults]). Confirming from
/// either page pops this page with the final [List<DenpaMenRecord>].
class DenpaMenSelectionPage extends ConsumerStatefulWidget {
  const DenpaMenSelectionPage({super.key, required this.args});

  final DenpaMenSelectionArgs args;

  @override
  ConsumerState<DenpaMenSelectionPage> createState() =>
      _DenpaMenSelectionPageState();
}

class _DenpaMenSelectionPageState extends ConsumerState<DenpaMenSelectionPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );

  late final StateController<DenpaMenSearchQuery> _draftNotifier;
  late final StateController<DenpaMenSearchQuery> _queryNotifier;
  late final StateController<List<DenpaMenRecord>> _selectionNotifier;
  late final DenpaMenSearchQuerySnapshot _searchSnapshot;

  @override
  void initState() {
    super.initState();
    _draftNotifier = ref.read(searchFormDraftProvider.notifier);
    _queryNotifier = ref.read(searchQueryProvider.notifier);
    _selectionNotifier = ref.read(denpaMenSelectionProvider.notifier);
    _searchSnapshot = DenpaMenSearchQuerySnapshot(
      draft: _draftNotifier.state,
      applied: _queryNotifier.state,
    );
    Future(() => _selectionNotifier.state = []);
    _seedInitialSelection();
  }

  Future<void> _seedInitialSelection() async {
    final masterData = await ref.read(masterDataProvider.future);
    if (!mounted) return;
    final records = await ref.read(denpaMenListProvider(masterData).future);
    if (!mounted) return;
    _selectionNotifier.state = [
      for (final record in records)
        if (widget.args.initialSelectedIds.contains(record.denpaMen.id))
          record,
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    final snapshot = _searchSnapshot;
    final draftNotifier = _draftNotifier;
    final queryNotifier = _queryNotifier;
    final selectionNotifier = _selectionNotifier;
    Future(() {
      draftNotifier.state = snapshot.draft;
      queryNotifier.state = snapshot.applied;
      selectionNotifier.state = [];
    });
    super.dispose();
  }

  bool get _canConfirm {
    final count = _selectionNotifier.state.length;
    return count == 0 || count == widget.args.maxSelectable;
  }

  void _confirm() {
    Navigator.of(context).pop(_selectionNotifier.state);
  }

  void _toggle(DenpaMenRecord record) {
    final selected = _selectionNotifier.state;
    if (selected.any((r) => r.id == record.id)) {
      _selectionNotifier.state = [
        for (final r in selected)
          if (r.id != record.id) r,
      ];
    } else if (selected.length < widget.args.maxSelectable) {
      _selectionNotifier.state = [...selected, record];
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final masterDataAsync = ref.watch(masterDataProvider);
    final selected = ref.watch(denpaMenSelectionProvider);

    listenForMasterDataErrors(ref, context);

    return AppScaffold(
      title: OutlinedTitleText(text: t.editableStatus.parents),
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: _canConfirm ? _confirm : null,
        ),
      ],
      floatingActionButton: AnimatedBuilder(
        animation: _tabController,
        builder: (context, _) {
          if (_tabController.index != 1) return const SizedBox.shrink();
          return masterDataAsync.maybeWhen(
            data: (masterData) => FloatingActionButton(
              onPressed: () async {
                ref.read(searchQueryProvider.notifier).state = ref.read(
                  searchFormDraftProvider,
                );
                await DenpaMenSelectionSearchRoute(
                  $extra: widget.args,
                ).push<bool>(context);
              },
              child: const Icon(Icons.search),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: t.search.tabList),
              Tab(text: t.search.tabSearch),
            ],
          ),
          Expanded(
            child: masterDataAsync.when(
              data: (masterData) {
                final candidatesAsync = ref.watch(
                  denpaMenListProvider(masterData),
                );
                return candidatesAsync.when(
                  data: (records) {
                    final candidates = [
                      for (final record in records)
                        if (record.denpaMen.id != widget.args.excludeId)
                          record,
                    ];
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          itemCount: candidates.length,
                          itemBuilder: (context, index) {
                            final record = candidates[index];
                            return DenpaMenListTile(
                              denpaMen: record.denpaMen,
                              selectionMode: true,
                              selected: selected.any(
                                (r) => r.id == record.id,
                              ),
                              onSelectedChanged: (_) => _toggle(record),
                              enableLongPressPreview: false,
                            );
                          },
                        ),
                        SearchForm(
                          headShapes: masterData.headShapes,
                          anntenas: masterData.anntenas,
                        ),
                      ],
                    );
                  },
                  loading: () => const ProgressBar(),
                  error: (error, stackTrace) => const SizedBox.shrink(),
                );
              },
              loading: () => const ProgressBar(),
              error: (error, stackTrace) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class DenpaMenSearchQuerySnapshot {
  const DenpaMenSearchQuerySnapshot({
    required this.draft,
    required this.applied,
  });

  final DenpaMenSearchQuery draft;
  final DenpaMenSearchQuery applied;
}
