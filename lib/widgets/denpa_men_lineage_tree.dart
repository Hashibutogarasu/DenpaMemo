import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../domain/qr_code/qr_code_record.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/qr_code_providers.dart';
import 'dialog/denpa_men_preview_dialog.dart';
import 'lineage/denpa_men_node.dart';
import 'lineage/lineage_edge_renderer.dart';
import 'lineage/qr_code_node.dart';

/// Shows every saved QR code as the root of a tree, in a single shared
/// canvas: individuals caught directly under it (ordered by catch order,
/// centered on the first one caught), then any bred descendants reached by
/// following `DenpaMen.parentIds` — connected with an edge from each of its
/// (up to two) parents, so shared offspring visibly converge. Every QR code
/// hangs off one invisible super-root so the whole forest lays out as a
/// single connected diagram.
class DenpaMenLineageTree extends ConsumerWidget {
  const DenpaMenLineageTree({super.key, required this.masterData});

  final MasterData masterData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrCodesAsync = ref.watch(qrCodeListProvider);
    final denpaMenAsync = ref.watch(denpaMenListProvider(masterData));

    return qrCodesAsync.when(
      data: (qrCodes) => denpaMenAsync.when(
        data: (denpaMenRecords) {
          if (qrCodes.isEmpty) {
            return Center(child: Text(context.t.home.empty));
          }
          return _LineageGraph(
            qrCodes: qrCodes,
            denpaMenRecords: denpaMenRecords,
            masterData: masterData,
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

/// Reorders [items] so the first entry ends up in the middle of the
/// returned list, with the rest fanning out alternately to its left and
/// right in their original order.
List<T> _centerFirst<T>(List<T> items) {
  final result = <T>[];
  for (var i = 0; i < items.length; i++) {
    if (i.isEven) {
      result.add(items[i]);
    } else {
      result.insert(0, items[i]);
    }
  }
  return result;
}

enum _NodeKind { invisible, qrCode, caughtDenpaMen, bredDenpaMen }

class _NodeInfo {
  const _NodeInfo({
    required this.kind,
    this.rawValue,
    this.name,
    this.catchIndex,
    this.denpaMen,
  });

  final _NodeKind kind;
  final String? rawValue;
  final String? name;
  final int? catchIndex;
  final DenpaMen? denpaMen;
}

class _LineageGraph extends StatelessWidget {
  const _LineageGraph({
    required this.qrCodes,
    required this.denpaMenRecords,
    required this.masterData,
  });

  final List<QrCodeRecord> qrCodes;
  final List<DenpaMenRecord> denpaMenRecords;
  final MasterData masterData;

  void _showPreview(BuildContext context, DenpaMen denpaMen) {
    showDialog<void>(
      context: context,
      builder: (context) => DenpaMenPreviewDialog(
        denpaMen: denpaMen,
        totalAttributeCount: masterData.attributes.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const nodeSize = 64.0;
    const superRootKey = 'superRoot';

    final graph = Graph();
    final nodeInfoByKey = <Object, _NodeInfo>{};
    final addedIds = <String>{};

    final superRootNode = Node.Id(superRootKey);
    graph.addNode(superRootNode);
    nodeInfoByKey[superRootKey] = const _NodeInfo(kind: _NodeKind.invisible);

    for (final qrCodeRecord in qrCodes) {
      final qrCode = qrCodeRecord.qrCode;
      final rootKey = 'qr:${qrCode.id}';
      graph.addEdge(
        superRootNode,
        Node.Id(rootKey),
        paint: Paint()..color = Colors.transparent,
      );
      nodeInfoByKey[rootKey] = _NodeInfo(
        kind: _NodeKind.qrCode,
        rawValue: qrCode.rawValue,
      );

      final directChildren =
          denpaMenRecords
              .where((record) => record.denpaMen.qrCodeId == qrCode.id)
              .toList()
            ..sort(
              (a, b) => (a.denpaMen.catchOrder ?? 0).compareTo(
                b.denpaMen.catchOrder ?? 0,
              ),
            );

      for (final record in _centerFirst(directChildren)) {
        final id = record.denpaMen.id;
        if (!addedIds.add(id)) {
          continue;
        }
        nodeInfoByKey[id] = _NodeInfo(
          kind: _NodeKind.caughtDenpaMen,
          name: record.denpaMen.name,
          catchIndex: (record.denpaMen.catchOrder ?? 0) + 1,
          denpaMen: record.denpaMen,
        );
        graph.addEdge(Node.Id(rootKey), Node.Id(id));
      }
    }

    var progress = true;
    while (progress) {
      progress = false;
      for (final record in denpaMenRecords) {
        final id = record.denpaMen.id;
        final parentIds = record.denpaMen.parentIds;
        if (addedIds.contains(id) || parentIds.isEmpty) {
          continue;
        }
        if (!parentIds.every(addedIds.contains)) {
          continue;
        }
        nodeInfoByKey[id] = _NodeInfo(
          kind: _NodeKind.bredDenpaMen,
          name: record.denpaMen.name,
          denpaMen: record.denpaMen,
        );
        for (final parentId in parentIds) {
          graph.addEdge(Node.Id(parentId), Node.Id(id));
        }
        addedIds.add(id);
        progress = true;
      }
    }

    final config = SugiyamaConfiguration()
      ..nodeSeparation = 32
      ..levelSeparation = 48
      ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
    final edgeRendererConfig = BuchheimWalkerConfiguration()
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
    final algorithm = SugiyamaAlgorithm(config)
      ..renderer = LineageEdgeRenderer(edgeRendererConfig);

    return GraphView.builder(
      graph: graph,
      algorithm: algorithm,
      autoZoomToFit: true,
      centerGraph: true,
      builder: (node) {
        final info = nodeInfoByKey[node.key!.value];
        return switch (info?.kind) {
          _NodeKind.qrCode => QrCodeNode(
            rawValue: info!.rawValue!,
            size: nodeSize,
          ),
          _NodeKind.caughtDenpaMen => GestureDetector(
            onTap: () => _showPreview(context, info.denpaMen!),
            child: DenpaMenNode(
              name: info!.name!,
              catchIndex: info.catchIndex,
              size: nodeSize,
            ),
          ),
          _NodeKind.bredDenpaMen => GestureDetector(
            onTap: () => _showPreview(context, info.denpaMen!),
            child: DenpaMenNode(name: info!.name!, size: nodeSize),
          ),
          _NodeKind.invisible || null => SizedBox(
            width: nodeSize,
            height: nodeSize,
          ),
        };
      },
    );
  }
}
