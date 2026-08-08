import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/master_data_providers.dart';
import '../routing/app_router.dart';
import '../theme/app_colors.dart';
import '../widgets/denpa_men_accordion_tile.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';
import '../widgets/selection_floating_menu.dart';
import 'denpa_men_editor.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  Future<void> _exportSelected(
    BuildContext context,
    WidgetRef ref,
    MasterData masterData,
  ) async {
    final t = context.t;
    final records =
        ref.read(denpaMenListProvider(masterData)).valueOrNull ?? [];
    final selectedIds = ref.read(selectedDenpaMenIdsProvider);
    final selected = [
      for (final record in records)
        if (selectedIds.contains(record.id)) record.denpaMen.toJson(),
    ];
    await Clipboard.setData(ClipboardData(text: jsonEncode(selected)));
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.home.exportedToClipboard)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);
    final t = context.t;
    final selectedCount = ref.watch(selectedDenpaMenIdsProvider).length;
    final masterData = masterDataAsync.valueOrNull;

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.home),
      actions: [
        PopupMenuButton<void>(
          icon: const Icon(Icons.more_vert, color: AppColors.accent),
          itemBuilder: (context) => [
            PopupMenuItem(
              enabled: selectedCount > 0,
              onTap: masterData == null
                  ? null
                  : () => _exportSelected(context, ref, masterData),
              child: Text(t.home.exportSelected),
            ),
          ],
        ),
      ],
      body: masterDataAsync.when(
        data: (masterData) => _HomeBody(masterData: masterData),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
      floatingActionButton: masterDataAsync.maybeWhen(
        data: (masterData) => FloatingActionButton(
          onPressed: () => AddDenpaMenRoute(
            $extra: DenpaMenEditorArgs(masterData: masterData),
          ).push(context),
          child: const Icon(Icons.add),
        ),
        orElse: () => null,
      ),
    );
  }
}

/// Scrollable accordion listing every saved [DenpaMen] as a collapsed
/// preview; expanding an entry reveals its full [DenpaMenStatus] plus edit
/// and delete actions (see [DenpaMenAccordionTile]). When multi-select mode
/// is active, a [SelectionFloatingMenu] surfaces bulk actions for the
/// current selection.
class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.masterData});

  final MasterData masterData;

  void _setSelected(WidgetRef ref, int id, bool selected) {
    final ids = Set<int>.from(ref.read(selectedDenpaMenIdsProvider));
    if (selected) {
      ids.add(id);
    } else {
      ids.remove(id);
    }
    ref.read(selectedDenpaMenIdsProvider.notifier).state = ids;
    ref.read(selectionModeProvider.notifier).state = ids.isNotEmpty;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(denpaMenListProvider(masterData));
    final selectionMode = ref.watch(selectionModeProvider);
    final selectedIds = ref.watch(selectedDenpaMenIdsProvider);
    final cutIds = ref.watch(cutDenpaMenIdsProvider);

    return Stack(
      children: [
        Positioned.fill(
          child: recordsAsync.when(
            data: (records) {
              if (records.isEmpty) {
                return Center(child: Text(context.t.home.empty));
              }
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DenpaMenAccordionTile(
                      record: record,
                      masterData: masterData,
                      selectionMode: selectionMode,
                      selected: selectedIds.contains(record.id),
                      isCut: cutIds.contains(record.id),
                      onSelectedChanged: (selected) =>
                          _setSelected(ref, record.id, selected),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('$error')),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SelectionFloatingMenu(masterData: masterData),
            ),
          ),
        ),
      ],
    );
  }
}
