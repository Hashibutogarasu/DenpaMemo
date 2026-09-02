import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../pages/denpa_men_editor.dart';
import '../providers/denpa_men_providers.dart';
import '../routing/app_router.dart';
import 'generic_selection_floating_menu.dart';

/// Rounded floating action bar shown above the home list while the list is
/// in multi-select mode, offering select-all/deselect-all and bulk
/// copy/cut/delete of the selection.
class SelectionFloatingMenu extends ConsumerWidget {
  const SelectionFloatingMenu({
    super.key,
    required this.masterData,
    this.duration = const Duration(milliseconds: 200),
  });

  final MasterData masterData;
  final Duration duration;

  void _edit(BuildContext context, WidgetRef ref) {
    final records = ref.read(denpaMenListProvider(masterData)).value ?? [];
    final selectedIds = ref.read(selectedDenpaMenIdsProvider);
    if (selectedIds.length != 1) {
      return;
    }
    final record = records.firstWhereOrNull(
      (record) => record.id == selectedIds.single,
    );
    if (record != null) {
      AddDenpaMenRoute(
        $extra: DenpaMenEditorArgs(masterData: masterData, initial: record),
      ).push(context);
    }
  }

  void _copy(WidgetRef ref) {
    final records = ref.read(denpaMenListProvider(masterData)).value ?? [];
    final selectedIds = ref.read(selectedDenpaMenIdsProvider);
    final denpaMens = [
      for (final record in records)
        if (selectedIds.contains(record.id)) record.denpaMen,
    ];
    ref.read(denpaMenClipboardProvider.notifier).state = denpaMens;
  }

  void _cut(WidgetRef ref) {
    _copy(ref);
    ref.read(cutDenpaMenIdsProvider.notifier).state = Set<int>.from(
      ref.read(selectedDenpaMenIdsProvider),
    );
    _clearSelection(ref);
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final selectedIds = ref.read(selectedDenpaMenIdsProvider);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.home.deleteConfirmTitle),
        content: Text(t.home.deleteSelectedConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.common.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.common.delete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      final repository = ref.read(denpaMenRepositoryProvider);
      for (final id in selectedIds) {
        repository.delete(id);
      }
      _clearSelection(ref);
    }
  }

  void _clearSelection(WidgetRef ref) {
    ref.read(selectedDenpaMenIdsProvider.notifier).state = {};
    ref.read(selectionModeProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final selectedIds = ref.watch(selectedDenpaMenIdsProvider);
    final visible = ref.watch(selectionModeProvider);
    final records = ref.watch(denpaMenListProvider(masterData)).value ?? [];
    final allSelected =
        records.isNotEmpty &&
        records.every((record) => selectedIds.contains(record.id));

    return GenericSelectionFloatingMenu(
      visible: visible,
      allSelected: allSelected,
      onToggleSelectAll: () =>
          ref.read(selectedDenpaMenIdsProvider.notifier).state = allSelected
          ? {}
          : {for (final record in records) record.id},
      selectAllTooltip: t.home.selectAll,
      deselectAllTooltip: t.home.deselectAll,
      onCancel: () => _clearSelection(ref),
      cancelTooltip: t.common.cancel,
      duration: duration,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          color: AppColors.accent,
          disabledColor: AppColors.accent.withValues(alpha: 0.3),
          tooltip: t.common.edit,
          onPressed: selectedIds.length == 1 ? () => _edit(context, ref) : null,
        ),
        IconButton(
          icon: const Icon(Icons.copy, color: AppColors.accent),
          tooltip: t.home.copySelected,
          onPressed: () => _copy(ref),
        ),
        IconButton(
          icon: const Icon(Icons.content_cut, color: AppColors.accent),
          tooltip: t.home.cutSelected,
          onPressed: () => _cut(ref),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: AppColors.accent),
          tooltip: t.common.delete,
          onPressed: () => _delete(context, ref),
        ),
      ],
    );
  }
}
