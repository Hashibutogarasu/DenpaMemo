import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/master_data_providers.dart';
import '../providers/search_providers.dart';
import '../routing/app_router.dart';
import '../widgets/dialog/master_data_error_listener.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/progress_bar.dart';
import '../widgets/scaffold/app_scaffold.dart';
import '../widgets/search/search_form.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);
    final t = context.t;

    listenForMasterDataErrors(ref, context);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.search),
      body: masterDataAsync.when(
        data: (masterData) => SearchForm(
          headShapes: masterData.headShapes,
          anntenas: masterData.anntenas,
        ),
        loading: () => const ProgressBar(),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
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
