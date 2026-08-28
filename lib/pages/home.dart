import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/dm_export_providers.dart';
import '../providers/dm_import_providers.dart';
import '../providers/home_view_providers.dart';
import '../providers/responsive_providers.dart';
import '../widgets/add_denpa_men_fab.dart';
import '../widgets/dialog/import_complete_dialog.dart';
import '../widgets/dialog/master_data_error_listener.dart';
import '../widgets/home/denpa_men_home_screen.dart';
import '../widgets/scaffold/app_scaffold.dart';
import '../widgets/search/search_overlay_bar.dart';
import 'package:graphql_client/graphql_client.dart';

final _addFabLayerLink = LayerLink();

Future<void> _importFromFile(BuildContext context, WidgetRef ref) async {
  final result = await ref
      .read(dmImportControllerProvider)
      .importFromFile(context);
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

    listenForMasterDataErrors(ref, context);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyF, control: true): () =>
            ref.read(searchOverlayOpenProvider.notifier).state = !ref.read(
              searchOverlayOpenProvider,
            ),
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
                              onTap: () => exportSelectedDenpaMen(
                                context,
                                ref,
                                masterData,
                              ),
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
                        ? () => exportSelectedDenpaMen(context, ref, masterData)
                        : null,
                    mainButtonLayerLink: _addFabLayerLink,
                  ),
                ),
              ),
              loading: () => AppScaffold(
                title: OutlinedTitleText(text: t.page.home),
                body: const ProgressBar(),
              ),
              error: (error, stackTrace) => AppScaffold(
                title: OutlinedTitleText(text: t.page.home),
                body: const SizedBox.shrink(),
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SearchOverlayBar(),
            ),
            if (isMobile)
              _TreeSelectHoveredButton(fabLayerLink: _addFabLayerLink),
          ],
        ),
      ),
    );
  }
}

/// Tracks [fabLayerLink] (linked to [AddDenpaMenFab]'s own "+" button) via
/// [CompositedTransformFollower], so it renders directly above wherever
/// that button actually is, instead of assuming its position.
class _TreeSelectHoveredButton extends ConsumerWidget {
  const _TreeSelectHoveredButton({required this.fabLayerLink});

  final LayerLink fabLayerLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(homeViewModeProvider) != HomeViewMode.tree) {
      return const SizedBox.shrink();
    }
    final t = context.t;
    final hoveredId = ref.watch(hoveredTreeRecordIdProvider);
    final isSelected =
        hoveredId != null &&
        ref.watch(selectedDenpaMenIdsProvider).contains(hoveredId);

    return Positioned(
      right: 16,
      bottom: 16,
      child: CompositedTransformFollower(
        link: fabLayerLink,
        targetAnchor: Alignment.topCenter,
        followerAnchor: Alignment.bottomCenter,
        offset: const Offset(0, -16),
        child: FloatingActionButton(
          heroTag: 'tree-select-hovered',
          tooltip: isSelected
              ? t.home.deselectHoveredTreeIndividual
              : t.home.selectHoveredTreeIndividual,
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : null,
          onPressed: hoveredId == null
              ? null
              : () {
                  toggleDenpaMenSelection(ref, hoveredId);
                  if (ref.read(selectedDenpaMenIdsProvider).isNotEmpty) {
                    ref.read(selectionModeProvider.notifier).state = true;
                  }
                },
          child: Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
          ),
        ),
      ),
    );
  }
}
