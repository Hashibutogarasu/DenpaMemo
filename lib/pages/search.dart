import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/search_providers.dart';
import '../routing/app_router.dart';
import '../widgets/dialog/master_data_error_listener.dart';
import 'package:graphql_client/graphql_client.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);
    final masterData = masterDataAsync.value;
    final t = context.t;

    listenForMasterDataErrors(ref, context);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.search),
      body: masterData != null
          ? SearchForm(
              headShapes: masterData.headShapes,
              anntenas: masterData.anntenas,
              query: ref.watch(searchFormDraftProvider),
              onChanged: (value) =>
                  ref.read(searchFormDraftProvider.notifier).state = value,
            )
          : masterDataAsync.isLoading
          ? const ProgressBar()
          : const SizedBox.shrink(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(searchQueryProvider.notifier).state = ref.read(
            searchFormDraftProvider,
          );
          const SearchResultsRoute().push(context);
        },
        label: Text(t.page.search),
      ),
    );
  }
}
