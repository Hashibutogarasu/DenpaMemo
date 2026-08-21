import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../theme/app_colors.dart';

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

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedSlide(
        duration: duration,
        curve: Curves.easeOutCubic,
        offset: visible ? Offset.zero : const Offset(0, 1.5),
        child: AnimatedOpacity(
          duration: duration,
          curve: Curves.easeOutCubic,
          opacity: visible ? 1 : 0,
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 8,
            borderRadius: BorderRadius.circular(32),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      allSelected ? Icons.deselect : Icons.select_all,
                      color: AppColors.accent,
                    ),
                    tooltip: allSelected
                        ? t.home.deselectAll
                        : t.home.selectAll,
                    onPressed: () =>
                        ref
                            .read(selectedDenpaMenIdsProvider.notifier)
                            .state = allSelected
                        ? {}
                        : {for (final record in records) record.id},
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: AppColors.accent),
                    tooltip: t.home.copySelected,
                    onPressed: () => _copy(ref),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.content_cut,
                      color: AppColors.accent,
                    ),
                    tooltip: t.home.cutSelected,
                    onPressed: () => _cut(ref),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.accent),
                    tooltip: t.common.delete,
                    onPressed: () => _delete(context, ref),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.accent),
                    tooltip: t.common.cancel,
                    onPressed: () => _clearSelection(ref),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
