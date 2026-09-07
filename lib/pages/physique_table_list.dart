import 'package:flutter/material.dart';

import 'package:api_client/api_client.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:denpa_memo/widgets.dart';
import '../data/server/physique_table_args.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/app_initialization_providers.dart';
import '../providers/physique_table_cache_providers.dart';
import '../providers/physique_table_edit_providers.dart';
import '../providers/physiques_providers.dart';
import '../routing/app_router.dart';
import '../widgets/list/list_tile_section.dart';
import '../widgets/physique_table/physique_antenna_category_selection_dialog.dart';
import '../widgets/physique_table/table_type_selection_dialog.dart';

/// Prompts for the character's experience-based level (a number), not a
/// [Physique] size id — see [PhysiqueTableArgs].
Future<String?> _pickLevel(BuildContext context) {
  final controller = TextEditingController();
  return AppDialog.show<String>(
    context: context,
    builder: (context) {
      final t = context.t;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(t.physiqueTable.enterLevel),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            onChanged: (_) => setState(() {}),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.common.cancel),
            ),
            FilledButton(
              onPressed: controller.text.trim().isEmpty
                  ? null
                  : () => Navigator.of(context).pop(controller.text.trim()),
              child: Text(t.common.confirm),
            ),
          ],
        ),
      );
    },
  );
}

/// For each of [types], whether it already has at least one cached row
/// at [level]/[anntenaCategory] — shown as a ○/✕ mark in
/// [showTableTypeSelectionDialog] so the user can tell which types are
/// existing tables to view versus still-empty ones. Reads the local
/// cache rather than the server, so it never hangs or errors offline.
Map<String, bool> _typeAvailability(
  WidgetRef ref,
  List<TableDefinition> types,
  String level,
  String anntenaCategory,
) {
  final cacheRepository = ref.read(physiqueTableCacheRepositoryProvider);
  return {
    for (final type in types)
      type.type: cacheRepository.hasDataFor(
        PhysiqueTableArgs(
          type: type.type,
          level: level,
          anntenaCategory: anntenaCategory,
        ),
      ),
  };
}

/// Entry point for the developer-only physique table editor: lists every
/// antenna category (grouped by `PhysiqueAntennaCategory.category`, fetched
/// via GraphQL), then asks which level to open once one is tapped, before
/// pushing [PhysiqueTableViewRoute]. Table types (HP, speed, ...) are
/// fetched from the server's `/tables/types` registry via
/// [tableTypesProvider], not hardcoded. Before navigating to the view or
/// edit page for a chosen table, this page primes
/// [physiqueTableEditProvider] via `ensureLoaded()` and shows its own
/// [LoadingOverlay] meanwhile, so the destination page always mounts
/// with its data already in hand rather than loading itself.
class PhysiqueTableListPage extends ConsumerStatefulWidget {
  const PhysiqueTableListPage({super.key});

  @override
  ConsumerState<PhysiqueTableListPage> createState() =>
      _PhysiqueTableListPageState();
}

class _PhysiqueTableListPageState extends ConsumerState<PhysiqueTableListPage> {
  bool _navigating = false;

  Future<void> _navigateAfterLoading(
    PhysiqueTableArgs args,
    GoRouteData Function() buildRoute,
  ) async {
    setState(() => _navigating = true);
    await ref.read(physiqueTableEditProvider(args).notifier).ensureLoaded();
    if (!mounted) return;
    setState(() => _navigating = false);
    if (!context.mounted) return;
    buildRoute().push(context);
  }

  Future<void> _startEditingExistingTable(
    List<TableDefinition> types,
    String anntenaCategory,
  ) async {
    final level = await _pickLevel(context);
    if (level == null || !mounted) return;
    final dataAvailability = _typeAvailability(
      ref,
      types,
      level,
      anntenaCategory,
    );
    if (!mounted) return;
    final type = await showTableTypeSelectionDialog(
      context,
      types: types,
      dataAvailability: dataAvailability,
    );
    if (type == null || !mounted) return;
    final args = PhysiqueTableArgs(
      type: type.type,
      level: level,
      anntenaCategory: anntenaCategory,
    );
    await _navigateAfterLoading(
      args,
      () => PhysiqueTableEditRoute($extra: args),
    );
  }

  Future<void> _createNewTable(
    List<PhysiqueAntennaCategory> antennaCategories,
    List<TableDefinition> types,
  ) async {
    final level = await _pickLevel(context);
    if (level == null || !mounted) return;
    final type = await showTableTypeSelectionDialog(context, types: types);
    if (type == null || !mounted) return;
    final antennaCategory = await showPhysiqueAntennaCategorySelectionDialog(
      context,
      categories: antennaCategories,
    );
    if (antennaCategory == null || !mounted) return;
    final args = PhysiqueTableArgs(
      type: type.type,
      level: level,
      anntenaCategory: antennaCategory.anntenaCategory,
    );
    await _navigateAfterLoading(
      args,
      () => PhysiqueTableEditRoute($extra: args),
    );
  }

  Future<void> _viewExistingTable(
    List<TableDefinition> types,
    String anntenaCategory,
  ) async {
    final level = await _pickLevel(context);
    if (level == null || !mounted) return;
    final dataAvailability = _typeAvailability(
      ref,
      types,
      level,
      anntenaCategory,
    );
    if (!mounted) return;
    final type = await showTableTypeSelectionDialog(
      context,
      types: types,
      dataAvailability: dataAvailability,
    );
    if (type == null || !mounted) return;
    final args = PhysiqueTableArgs(
      type: type.type,
      level: level,
      anntenaCategory: anntenaCategory,
    );
    await _navigateAfterLoading(
      args,
      () => PhysiqueTableViewRoute($extra: args),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final metadata = ref.watch(cachedPhysiqueTableMetadataProvider);
    final types = ref.watch(cachedTableTypesProvider);
    final categoriesWithData = ref.watch(
      physiqueTableAnntenaCategoriesWithDataProvider,
    );

    return AppScaffold(
      title: OutlinedTitleText(text: t.physiqueTable.title),
      floatingActionButton: switch ((metadata, types)) {
        (final metadata?, final types?) => FloatingActionButton.extended(
          label: Text(t.physiqueTable.createNewTable),
          onPressed: () =>
              _createNewTable(metadata.physiqueAntennaCategories, types),
        ),
        _ => null,
      },
      body: switch ((metadata, types)) {
        (final metadata?, final types?) => LoadingOverlay(
          loading: _navigating,
          child: Builder(
            builder: (context) {
              final byCategory = <String, List<PhysiqueAntennaCategory>>{};
              for (final row in metadata.physiqueAntennaCategories) {
                byCategory.putIfAbsent(row.category, () => []).add(row);
              }

              return ListView(
                children: [
                  for (final entry in byCategory.entries) ...[
                    ListTileSection(title: Text(entry.key)),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListItemContainer(
                        children: [
                          for (final row in entry.value)
                            ListTile(
                              leading: const Icon(Icons.table_rows_outlined),
                              title: Text(row.anntenaCategory),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (categoriesWithData.contains(
                                    row.anntenaCategory,
                                  ))
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined),
                                      tooltip: t.physiqueTable.edit,
                                      onPressed: () =>
                                          _startEditingExistingTable(
                                            types,
                                            row.anntenaCategory,
                                          ),
                                    ),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                              onTap: () => _viewExistingTable(
                                types,
                                row.anntenaCategory,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
        _ => const ProgressBar(),
      },
    );
  }
}
