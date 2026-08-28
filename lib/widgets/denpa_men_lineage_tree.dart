import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_icon_providers.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/qr_code_providers.dart';
import '../providers/search_providers.dart';
import 'lineage/lineage_graph.dart';

/// Shows every saved QR code as the root of a tree, in a single shared
/// canvas: individuals caught directly under it (ordered by catch order),
/// then any bred descendants reached by following `DenpaMen.parentIds` —
/// connected with an edge from each of its (up to two) parents, so shared
/// offspring visibly converge. Every QR code hangs off one invisible
/// super-root so the whole forest lays out as a single connected diagram.
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

          return LineageGraph(
            qrCodes: qrCodes,
            denpaMenRecords: lineageRecords,
            masterData: masterData,
            iconsById: {
              for (final record in lineageRecords)
                record.denpaMen.id: ref
                    .watch(denpaMenIconProvider(record.denpaMen.id))
                    .value,
            },
            controller: controller,
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
