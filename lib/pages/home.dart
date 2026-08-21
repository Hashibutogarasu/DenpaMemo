import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/dm_export_providers.dart';
import '../providers/dm_import_providers.dart';
import '../providers/master_data_providers.dart';
import '../providers/responsive_providers.dart';
import '../theme/app_colors.dart';
import '../widgets/add_denpa_men_fab.dart';
import '../widgets/dialog/export_complete_dialog.dart';
import '../widgets/dialog/import_complete_dialog.dart';
import '../widgets/home/denpa_men_home_screen.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';
import '../widgets/search/search_overlay_bar.dart';

Future<void> _exportSelected(
  BuildContext context,
  WidgetRef ref,
  MasterData masterData,
) async {
  final t = context.t;
  final result = await ref
      .read(dmExportControllerProvider)
      .exportSelected(masterData, dialogTitle: t.home.exportDialogTitle);
  if (result != null && context.mounted) {
    await ExportCompleteDialog.show(context, result: result);
  }
}

Future<void> _importFromFile(BuildContext context, WidgetRef ref) async {
  final result = await ref.read(dmImportControllerProvider).importFromFile(context);
  if (result != null && context.mounted) {
    await ImportCompleteDialog.show(context, result: result);
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);
    final searchOverlayOpen = ref.watch(searchOverlayOpenProvider);
    final t = context.t;
    final selectedCount = ref.watch(selectedDenpaMenIdsProvider).length;
    final isMobile = ref.watch(isMobileLayoutProvider);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyF, control: true): () =>
            ref.read(searchOverlayOpenProvider.notifier).state =
                !ref.read(searchOverlayOpenProvider),
        if (searchOverlayOpen)
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              ref.read(searchOverlayOpenProvider.notifier).state = false,
      },
      child: Focus(
        autofocus: true,
        child: Stack(
          children: [
            masterDataAsync.when(
              data: (masterData) => DenpaMenHomeScreen(
                title: OutlinedTitleText(text: t.page.home),
                masterData: masterData,
                actions: isMobile
                    ? null
                    : [
                        PopupMenuButton<void>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.accent,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              enabled: selectedCount > 0,
                              onTap: () =>
                                  _exportSelected(context, ref, masterData),
                              child: Text(t.home.exportSelected),
                            ),
                            PopupMenuItem(
                              onTap: () => _importFromFile(context, ref),
                              child: Text(t.home.importFromFile),
                            ),
                          ],
                        ),
                      ],
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 72 : 0),
                  child: AddDenpaMenFab(
                    masterData: masterData,
                    onImport: isMobile
                        ? () => _importFromFile(context, ref)
                        : null,
                    onExport: isMobile && selectedCount > 0
                        ? () => _exportSelected(context, ref, masterData)
                        : null,
                  ),
                ),
              ),
              loading: () => AppScaffold(
                title: OutlinedTitleText(text: t.page.home),
                body: const Center(child: CircularProgressIndicator()),
              ),
              error: (error, stackTrace) => AppScaffold(
                title: OutlinedTitleText(text: t.page.home),
                body: Center(child: Text('$error')),
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SearchOverlayBar(),
            ),
          ],
        ),
      ),
    );
  }
}
