import 'dart:math' as math;

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
import 'lineage/qr_code_node.dart';

/// Shows every saved QR code as the root of a tree: individuals caught
/// directly under it (ordered by catch order, centered on the first one
/// caught), then any bred descendants reached by following
/// `DenpaMen.parentIds`.
class DenpaMenLineageTree extends ConsumerWidget {
  const DenpaMenLineageTree({super.key, required this.masterData});

  final MasterData masterData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrCodesAsync = ref.watch(qrCodeListProvider);
    final denpaMenAsync = ref.watch(denpaMenListProvider(masterData));

    return LayoutBuilder(
      builder: (context, constraints) {
        return qrCodesAsync.when(
          data: (qrCodes) => denpaMenAsync.when(
            data: (denpaMenRecords) {
              if (qrCodes.isEmpty) {
                return Center(child: Text(context.t.home.empty));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: qrCodes.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _QrLineageSection(
                    qrCodeRecord: qrCodes[index],
                    denpaMenRecords: denpaMenRecords,
                    viewportHeight: constraints.maxHeight,
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('$error')),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('$error')),
        );
      },
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

enum _NodeKind { qrCode, caughtDenpaMen, bredDenpaMen }

class _NodeInfo {
  const _NodeInfo({required this.kind, this.rawValue, this.catchIndex});

  final _NodeKind kind;
  final String? rawValue;
  final int? catchIndex;
}

class _QrLineageSection extends StatelessWidget {
  const _QrLineageSection({
    required this.qrCodeRecord,
    required this.denpaMenRecords,
    required this.viewportHeight,
  });

  final QrCodeRecord qrCodeRecord;
  final List<DenpaMenRecord> denpaMenRecords;
  final double viewportHeight;

  @override
  Widget build(BuildContext context) {
    final qrCode = qrCodeRecord.qrCode;
    final graph = Graph()..isTree = true;
    final nodeInfoByKey = <Object, _NodeInfo>{};
    final visited = <String>{};

    final rootKey = 'qr:${qrCode.id}';
    final rootNode = Node.Id(rootKey);
    graph.addNode(rootNode);
    nodeInfoByKey[rootKey] = _NodeInfo(
      kind: _NodeKind.qrCode,
      rawValue: qrCode.rawValue,
    );

    var nodeCount = 1;
    var maxDepth = 0;

    void addDescendants(Node parentNode, String parentDenpaMenId, int depth) {
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
        nodeCount++;
        maxDepth = math.max(maxDepth, depth);
        addDescendants(childNode, record.denpaMen.id, depth + 1);
      }
    }

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
      nodeCount++;
      maxDepth = math.max(maxDepth, 1);
      addDescendants(childNode, record.denpaMen.id, 2);
    }

    final config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 32
      ..levelSeparation = 48
      ..subtreeSeparation = 32
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    final canvasWidth = math.max(400.0, nodeCount * 140.0);
    final canvasHeight = math.max(240.0, (maxDepth + 1) * 140.0);

    return SizedBox(
      height: viewportHeight,
      child: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(64),
        minScale: 0.2,
        maxScale: 2,
        child: SizedBox(
          width: canvasWidth,
          height: canvasHeight,
          child: GraphView.builder(
            graph: graph,
            algorithm: BuchheimWalkerAlgorithm(
              config,
              TreeEdgeRenderer(config),
            ),
            autoZoomToFit: true,
            builder: (node) {
              final info = nodeInfoByKey[node.key!.value];
              return switch (info?.kind) {
                _NodeKind.qrCode => QrCodeNode(rawValue: info!.rawValue!),
                _NodeKind.caughtDenpaMen => CaughtDenpaMenNode(
                  catchIndex: info!.catchIndex!,
                ),
                _NodeKind.bredDenpaMen || null => const BredDenpaMenNode(),
              };
            },
          ),
        ),
      ),
    );
  }
}
