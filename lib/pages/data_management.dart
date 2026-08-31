import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/dm_import_providers.dart';

/// Entry point to the existing `.dm` file import flow. Exporting stays on
/// the home page's selection menu, since it already exports the selected
/// individuals there.
class DataManagementPage extends ConsumerWidget {
  const DataManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.dataManagement),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.file_upload_outlined),
            title: Text(t.settings.dataManagementImport),
            onTap: () =>
                ref.read(dmImportControllerProvider).importFromFile(context),
          ),
        ],
      ),
    );
  }
}
