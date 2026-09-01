import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/import_export_progress_providers.dart';

/// [AppShell]'s single bottom-of-screen progress indicator, shared by
/// every source of "the app is busy" so pages never render their own:
/// the running `.dm` export/import operation ([importExportProgressProvider],
/// determinate), falling back to [appShellStateProvider]'s [isLoading]
/// (indeterminate) when no export/import is running.
class AppShellProgressBar extends ConsumerWidget {
  const AppShellProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(importExportProgressProvider);
    if (progress != null) {
      return ProgressBar(value: progress.clamp(0.0, 1.0));
    }
    if (ref.watch(appShellStateProvider).isLoading) {
      return const ProgressBar();
    }
    return const SizedBox.shrink();
  }
}
