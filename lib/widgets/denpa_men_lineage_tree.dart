import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_icon_providers.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/qr_code_providers.dart';
import '../providers/search_providers.dart';
import 'dialog/denpa_men_action_menu.dart';
import 'dialog/denpa_men_preview_dialog.dart';

/// Shows every saved QR code as the root of a tree of caught/bred
/// individuals, all in one shared canvas.
class DenpaMenLineageTree extends ConsumerWidget {
  const DenpaMenLineageTree({
    super.key,
    required this.masterData,
    this.controller,
    this.cursorEnabled = false,
  });

  final MasterData masterData;
  final GraphViewController? controller;
  final bool cursorEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrCodesAsync = ref.watch(qrCodeListProvider);
    final denpaMenAsync = ref.watch(denpaMenListProvider(masterData));

    final denpaMenRecords = ref.watch(filteredDenpaMenProvider(masterData));

    return qrCodesAsync.when(
      data: (allQrCodes) => denpaMenAsync.when(
        data: (allDenpaMenRecords) {
          final recordsById = {
            for (final record in allDenpaMenRecords) record.denpaMen.id: record,
          };
          final lineageRecordsById = {
            for (final record in denpaMenRecords) record.denpaMen.id: record,
          };
          final pendingParentIds = [
            for (final record in denpaMenRecords) ...record.denpaMen.parentIds,
          ];
          while (pendingParentIds.isNotEmpty) {
            final parentId = pendingParentIds.removeLast();
            if (lineageRecordsById.containsKey(parentId)) continue;
            final parent = recordsById[parentId];
            if (parent == null) continue;
            lineageRecordsById[parentId] = parent;
            pendingParentIds.addAll(parent.denpaMen.parentIds);
          }
          final lineageRecords = lineageRecordsById.values.toList();

          final matchedQrCodeIds = {
            for (final record in lineageRecords) record.denpaMen.qrCodeId,
          };
          final qrCodes = [
            for (final qrCode in allQrCodes)
              if (matchedQrCodeIds.contains(qrCode.qrCode.id)) qrCode,
          ];
          if (qrCodes.isEmpty) {
            return Center(child: Text(context.t.home.empty));
          }

          return DenpaMenLineageGraph(
            qrCodes: qrCodes,
            denpaMenRecords: lineageRecords,
            iconsById: {
              for (final record in lineageRecords)
                record.denpaMen.id: ref
                    .watch(denpaMenIconProvider(record.denpaMen.id))
                    .value,
            },
            selectionMode: ref.watch(selectionModeProvider),
            selectedIds: ref.watch(selectedDenpaMenIdsProvider),
            onToggleSelection: (id) => toggleDenpaMenSelection(ref, id),
            onMiddleClickSelect: (id) {
              ref.read(selectionModeProvider.notifier).state = true;
              toggleDenpaMenSelection(ref, id);
            },
            onTapNode: (context, denpaMen) =>
                DenpaMenPreviewDialog.show(context, denpaMen: denpaMen),
            onHoveredRecordChanged: (id) =>
                ref.read(hoveredTreeRecordIdProvider.notifier).state = id,
            contextMenuBuilder: (context, record, child) =>
                DenpaMenContextMenuArea(
                  record: record,
                  masterData: masterData,
                  child: child,
                ),
            graphViewController: controller,
            cursorEnabled: cursorEnabled,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('$error')),
    );
  }
}
