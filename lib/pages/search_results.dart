import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/search_providers.dart';
import '../widgets/dialog/master_data_error_listener.dart';
import '../widgets/home/denpa_men_home_screen.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/progress_bar.dart';
import '../widgets/scaffold/app_scaffold.dart';
import 'package:graphql_client/graphql_client.dart';

/// Shows [filteredDenpaMenProvider]'s matches for the current
/// [searchQueryProvider]. Resets that query in [dispose], not just on the
/// on-screen back button: [Home] reads the same provider for its own
/// quick-search overlay, so leaving this page by any means (button,
/// Escape, or the platform back gesture) must clear it, or Home would
/// keep showing these search results too. The notifier is captured in
/// [initState] rather than lazily, since a `late final` initializer would
/// otherwise run on its first access — which, absent any earlier read,
/// would be [dispose] itself, by which point `ref` can no longer be used.
/// The reset itself is deferred with [Future] because [dispose] runs
/// while the widget tree is locked for unmounting, and Riverpod forbids
/// modifying a provider during that window.
class SearchResults extends ConsumerStatefulWidget {
  const SearchResults({super.key});

  @override
  ConsumerState<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends ConsumerState<SearchResults> {
  late final StateController<DenpaMenSearchQuery> _searchQueryNotifier;

  @override
  void initState() {
    super.initState();
    _searchQueryNotifier = ref.read(searchQueryProvider.notifier);
  }

  @override
  void dispose() {
    final notifier = _searchQueryNotifier;
    Future(() => notifier.state = const DenpaMenSearchQuery());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final masterDataAsync = ref.watch(masterDataProvider);

    listenForMasterDataErrors(ref, context);

    return masterDataAsync.when(
      data: (masterData) => DenpaMenHomeScreen(
        title: OutlinedTitleText(text: context.t.page.searchResults),
        masterData: masterData,
      ),
      loading: () => AppScaffold(
        title: OutlinedTitleText(text: context.t.page.searchResults),
        body: const ProgressBar(),
      ),
      error: (error, stackTrace) => AppScaffold(
        title: OutlinedTitleText(text: context.t.page.searchResults),
        body: const SizedBox.shrink(),
      ),
    );
  }
}
