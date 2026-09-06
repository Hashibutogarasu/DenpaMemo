import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import '../../providers/denpa_men_providers.dart';
import '../../providers/home_view_providers.dart';
import '../../providers/import_export_progress_providers.dart';
import '../../providers/qr_code_providers.dart';

/// [AppShell]'s single bottom-of-screen progress indicator, shared by
/// every source of "the app is busy" so pages never render their own:
/// the running `.dm` export/import operation ([importExportProgressProvider],
/// determinate), falling back to the home screen's own data-loading
/// [AsyncValue]s (indeterminate) while no export/import is running.
class AppShellProgressBar extends ConsumerWidget {
  const AppShellProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(importExportProgressProvider);
    if (progress != null) {
      return ProgressBar(value: progress.clamp(0.0, 1.0));
    }

    final viewMode = ref.watch(homeViewModeProvider);
    return ref
        .watch(masterDataProvider)
        .when(
          data: (masterData) => ref
              .watch(denpaMenListProvider(masterData))
              .when(
                data: (_) => viewMode == HomeViewMode.tree
                    ? ref
                          .watch(qrCodeListProvider)
                          .when(
                            data: (_) => const SizedBox.shrink(),
                            loading: () => const ProgressBar(),
                            error: (_, _) => const SizedBox.shrink(),
                          )
                    : const SizedBox.shrink(),
                loading: () => const ProgressBar(),
                error: (_, _) => const SizedBox.shrink(),
              ),
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        );
  }
}
