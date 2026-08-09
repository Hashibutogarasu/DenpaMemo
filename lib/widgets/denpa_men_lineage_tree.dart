import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../domain/qr_code/qr_code_record.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/qr_code_providers.dart';
import 'lineage/bred_denpa_men_node.dart';
import 'lineage/caught_denpa_men_node.dart';
import 'lineage/lineage_edge_renderer.dart';
import 'lineage/qr_code_node.dart';

/// Shows every saved QR code as the root of a tree, in a single shared
/// canvas: individuals caught directly under it (ordered by catch order,
/// centered on the first one caught), then any bred descendants reached by
/// following `DenpaMen.parentIds`. Every QR code hangs off one invisible
/// super-root so the whole forest lays out as a single connected tree.
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
          return _LineageGraph(qrCodes: qrCodes, denpaMenRecords: denpaMenRecords);
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
  const _NodeInfo({required this.kind, this.rawValue, this.catchIndex});

  final _NodeKind kind;
  final String? rawValue;
  final int? catchIndex;
}

class _LineageGraph extends StatelessWidget {
  const _LineageGraph({required this.qrCodes, required this.denpaMenRecords});

  final List<QrCodeRecord> qrCodes;
  final List<DenpaMenRecord> denpaMenRecords;

  @override
  Widget build(BuildContext context) {
    const nodeSize = 64.0;
    const superRootKey = 'superRoot';

    final graph = Graph()..isTree = true;
    final nodeInfoByKey = <Object, _NodeInfo>{};
    final visited = <String>{};

    final superRootNode = Node.Id(superRootKey);
    graph.addNode(superRootNode);
    nodeInfoByKey[superRootKey] = const _NodeInfo(kind: _NodeKind.invisible);

    void addDescendants(Node parentNode, String parentDenpaMenId) {
      for (final record in denpaMenRecords) {
        if (!record.denpaMen.parentIds.contains(parentDenpaMenId)) {
          continue;
        }
        if (!visited.add(record.denpaMen.id)) {
          continue;
        }
        final childNode = Node.Id(record.denpaMen.id);
        nodeInfoByKey[record.denpaMen.id] = const _NodeInfo(
          kind: _NodeKind.bredDenpaMen,
        );
        graph.addEdge(parentNode, childNode);
        addDescendants(childNode, record.denpaMen.id);
      }
    }

    for (final qrCodeRecord in qrCodes) {
      final qrCode = qrCodeRecord.qrCode;
      final rootKey = 'qr:${qrCode.id}';
      final rootNode = Node.Id(rootKey);
      graph.addEdge(
        superRootNode,
        rootNode,
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
        if (!visited.add(record.denpaMen.id)) {
          continue;
        }
        final childNode = Node.Id(record.denpaMen.id);
        nodeInfoByKey[record.denpaMen.id] = _NodeInfo(
          kind: _NodeKind.caughtDenpaMen,
          catchIndex: (record.denpaMen.catchOrder ?? 0) + 1,
        );
        graph.addEdge(rootNode, childNode);
        addDescendants(childNode, record.denpaMen.id);
      }
    }

    final config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 32
      ..levelSeparation = 48
      ..subtreeSeparation = 32
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    return GraphView.builder(
      graph: graph,
      algorithm: BuchheimWalkerAlgorithm(config, LineageEdgeRenderer(config)),
      autoZoomToFit: true,
      centerGraph: true,
      builder: (node) {
        final info = nodeInfoByKey[node.key!.value];
        return switch (info?.kind) {
          _NodeKind.qrCode => QrCodeNode(
            rawValue: info!.rawValue!,
            size: nodeSize,
          ),
          _NodeKind.caughtDenpaMen => CaughtDenpaMenNode(
            catchIndex: info!.catchIndex!,
            size: nodeSize,
          ),
          _NodeKind.bredDenpaMen => BredDenpaMenNode(size: nodeSize),
          _NodeKind.invisible || null => SizedBox(
            width: nodeSize,
            height: nodeSize,
          ),
        };
      },
    );
  }
}
