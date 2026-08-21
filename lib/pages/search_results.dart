import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/master_data_providers.dart';
import '../widgets/home/denpa_men_home_screen.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);

    return masterDataAsync.when(
      data: (masterData) => DenpaMenHomeScreen(
        title: OutlinedTitleText(text: context.t.page.searchResults),
        masterData: masterData,
      ),
      loading: () => AppScaffold(
        title: OutlinedTitleText(text: context.t.page.searchResults),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => AppScaffold(
        title: OutlinedTitleText(text: context.t.page.searchResults),
        body: Center(child: Text('$error')),
      ),
    );
  }
}
