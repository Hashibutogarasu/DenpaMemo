import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/import_export_progress_providers.dart';

/// A bottom-of-screen progress indicator for the currently running `.dm`
/// export/import operation. Renders nothing while
/// [importExportProgressProvider] is null; shows a bare [ProgressBar]
/// (no label, no percentage text) otherwise.
class ImportExportProgressBar extends ConsumerWidget {
  const ImportExportProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(importExportProgressProvider);
    if (progress == null) {
      return const SizedBox.shrink();
    }
    return ProgressBar(value: progress.clamp(0.0, 1.0));
  }
}
