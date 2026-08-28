import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../providers/import_export_progress_providers.dart';
import 'import_export_progress_bar.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: ImportExportProgressBar,
  path: 'denpa_men',
)
Widget importExportProgressBarUseCase(BuildContext context) {
  final running = context.knobs.boolean(label: '実行中', initialValue: true);
  final progress = context.knobs.double.slider(
    label: '進捗値',
    initialValue: 0.4,
    min: 0,
    max: 1,
  );

  return ProviderScope(
    overrides: [
      importExportProgressProvider.overrideWith((ref) => running ? progress : null),
    ],
    child: const ImportExportProgressBar(),
  );
}
