import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_selection_providers.dart';
import '../providers/search_providers.dart';
import '../widgets/denpa_men_list_tile.dart';
import '../widgets/dialog/master_data_error_listener.dart';
import '../widgets/scaffold/app_scaffold.dart';
import 'package:graphql_client/graphql_client.dart';

/// Search results reached from [DenpaMenSelectionPage]'s search tab. Tapping
/// a result toggles it in [denpaMenSelectionProvider] instead of opening a
/// preview; the header checkmark pops this page with `true` once the
/// selection satisfies [maxSelectable], letting the caller finish the whole
/// flow. Unlike [SearchResults] this never shows a floating bulk-action
/// menu, since it isn't the home list's multi-select mode.
class DenpaMenSelectionSearchResults extends ConsumerStatefulWidget {
  const DenpaMenSelectionSearchResults({
    super.key,
    required this.excludeId,
    required this.maxSelectable,
  });

  final String excludeId;
  final int maxSelectable;

  @override
  ConsumerState<DenpaMenSelectionSearchResults> createState() =>
      _DenpaMenSelectionSearchResultsState();
}

class _DenpaMenSelectionSearchResultsState
    extends ConsumerState<DenpaMenSelectionSearchResults> {
  late final StateController<DenpaMenSearchQuery> _searchQueryNotifier;
  late final StateController<List<DenpaMenRecord>> _selectionNotifier;

  @override
  void initState() {
    super.initState();
    _searchQueryNotifier = ref.read(searchQueryProvider.notifier);
    _selectionNotifier = ref.read(denpaMenSelectionProvider.notifier);
  }

  @override
  void dispose() {
    final notifier = _searchQueryNotifier;
    Future(() => notifier.state = const DenpaMenSearchQuery());
    super.dispose();
  }

  bool _canConfirm(int count) =>
      count == 0 || count == widget.maxSelectable;

  void _toggle(DenpaMenRecord record) {
    final selected = _selectionNotifier.state;
    if (selected.any((r) => r.id == record.id)) {
      _selectionNotifier.state = [
        for (final r in selected)
          if (r.id != record.id) r,
      ];
    } else if (selected.length < widget.maxSelectable) {
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
      title: OutlinedTitleText(text: t.page.searchResults),
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: _canConfirm(selected.length)
              ? () => Navigator.of(context).pop(true)
              : null,
        ),
      ],
      body: masterDataAsync.when(
        data: (masterData) {
          final records = [
            for (final r in ref.watch(filteredDenpaMenProvider(masterData)))
              if (r.denpaMen.id != widget.excludeId) r,
          ];
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return DenpaMenListTile(
                denpaMen: record.denpaMen,
                selectionMode: true,
                selected: selected.any((r) => r.id == record.id),
                onSelectedChanged: (_) => _toggle(record),
                enableLongPressPreview: false,
              );
            },
          );
        },
        loading: () => const ProgressBar(),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}
