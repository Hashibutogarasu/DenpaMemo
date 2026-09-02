import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';

import '../data/server/physique_table_args.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/physiques_providers.dart';
import '../routing/app_router.dart';
import '../widgets/list/list_item_container.dart';
import '../widgets/list/list_tile_section.dart';
import '../widgets/physique_table/physique_antenna_category_selection_dialog.dart';

/// Prompts for the character's experience-based level (a number), not a
/// [Physique] size id — see [PhysiqueTableArgs].
Future<String?> _pickLevel(BuildContext context) {
  final controller = TextEditingController();
  return showDialog<String>(
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

/// Starts the edit-existing-table flow from the antenna category list:
/// pick which level's table to edit, then push straight to
/// [PhysiqueTableEditRoute].
Future<void> _startEditingExistingTable(BuildContext context, String anntenaCategory) async {
  final level = await _pickLevel(context);
  if (level == null || !context.mounted) return;
  PhysiqueTableEditRoute(
    $extra: PhysiqueTableArgs(level: level, anntenaCategory: anntenaCategory),
  ).push(context);
}

/// Starts the create-new-table flow: pick the level first, then
/// the antenna category, then push straight to [PhysiqueTableEditRoute]
/// (skipping the read-only view page, since there is nothing to view yet —
/// the table is empty until rows are added there).
Future<void> _createNewTable(
  BuildContext context,
  List<PhysiqueAntennaCategory> categories,
) async {
  final level = await _pickLevel(context);
  if (level == null || !context.mounted) return;
  final category = await showPhysiqueAntennaCategorySelectionDialog(
    context,
    categories: categories,
  );
  if (category == null || !context.mounted) return;
  PhysiqueTableEditRoute(
    $extra: PhysiqueTableArgs(level: level, anntenaCategory: category.anntenaCategory),
  ).push(context);
}

/// Entry point for the developer-only physique table editor: lists every
/// antenna category (grouped by `PhysiqueAntennaCategory.category`, fetched
/// via GraphQL), then asks which level to open once one is tapped, before
/// pushing [PhysiqueTableViewRoute]. The floating action button starts the
/// level-then-category picker flow and jumps straight to
/// [PhysiqueTableEditRoute] to create a brand new table.
class PhysiqueTableListPage extends ConsumerWidget {
  const PhysiqueTableListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final categoriesAsync = ref.watch(physiqueAntennaCategoriesProvider);
    final categoriesWithDataAsync = ref.watch(physiqueTableAnntenaCategoriesWithDataProvider);
    final categoriesWithData = categoriesWithDataAsync.value ?? const <String>{};

    return AppScaffold(
      title: OutlinedTitleText(text: t.physiqueTable.title),
      floatingActionButton: categoriesAsync.when(
        data: (categories) => FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: Text(t.physiqueTable.createNewTable),
          onPressed: () => _createNewTable(context, categories),
        ),
        loading: () => null,
        error: (error, stackTrace) => null,
      ),
      body: categoriesAsync.when(
        data: (categories) {
          final byCategory = <String, List<PhysiqueAntennaCategory>>{};
          for (final row in categories) {
            byCategory.putIfAbsent(row.category, () => []).add(row);
          }

          return ListView(
            children: [
              for (final entry in byCategory.entries) ...[
                ListTileSection(title: Text(entry.key)),
                ListItemContainer(
                  children: [
                    for (final row in entry.value)
                      ListTile(
                        leading: const Icon(Icons.table_rows_outlined),
                        title: Text(row.anntenaCategory),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (categoriesWithData.contains(row.anntenaCategory))
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                tooltip: t.physiqueTable.edit,
                                onPressed: () =>
                                    _startEditingExistingTable(context, row.anntenaCategory),
                              ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () async {
                          final level = await _pickLevel(context);
                          if (level == null || !context.mounted) return;
                          PhysiqueTableViewRoute(
                            $extra: PhysiqueTableArgs(
                              level: level,
                              anntenaCategory: row.anntenaCategory,
                            ),
                          ).push(context);
                        },
                      ),
                  ],
                ),
              ],
            ],
          );
        },
        loading: () => const ProgressBar(),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}
