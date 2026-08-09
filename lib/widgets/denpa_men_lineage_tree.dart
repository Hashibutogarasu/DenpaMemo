import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../domain/qr_code/qr_code_record.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/qr_code_providers.dart';
import 'label/outlined_title.dart';

/// Shows every saved QR code as the root of a tree: individuals caught
/// directly under it (ordered by catch order), then any bred descendants
/// reached by following `DenpaMen.parentIds`.
class DenpaMenLineageTree extends ConsumerWidget {
  const DenpaMenLineageTree({super.key, required this.masterData});

  final MasterData masterData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final qrCodesAsync = ref.watch(qrCodeListProvider);
    final denpaMenAsync = ref.watch(denpaMenListProvider(masterData));

    return qrCodesAsync.when(
      data: (qrCodes) => denpaMenAsync.when(
        data: (denpaMenRecords) {
          if (qrCodes.isEmpty) {
            return Center(child: Text(t.home.empty));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: qrCodes.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _QrLineageSection(
                qrCodeRecord: qrCodes[index],
                denpaMenRecords: denpaMenRecords,
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
  }
}

class _QrLineageSection extends StatelessWidget {
  const _QrLineageSection({
    required this.qrCodeRecord,
    required this.denpaMenRecords,
  });

  final QrCodeRecord qrCodeRecord;
  final List<DenpaMenRecord> denpaMenRecords;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final qrCode = qrCodeRecord.qrCode;
    final graph = Graph()..isTree = true;
    final labels = <Object, String>{};
    final visited = <String>{};

    final rootKey = 'qr:${qrCode.id}';
    final rootNode = Node.Id(rootKey);
    graph.addNode(rootNode);
    labels[rootKey] = qrCode.name ?? qrCode.id;

    void addDescendants(Node parentNode, String parentDenpaMenId) {
      for (final record in denpaMenRecords) {
        if (!record.denpaMen.parentIds.contains(parentDenpaMenId)) {
          continue;
        }
        if (!visited.add(record.denpaMen.id)) {
          continue;
        }
        final childNode = Node.Id(record.denpaMen.id);
        labels[record.denpaMen.id] = record.denpaMen.name;
        graph.addEdge(parentNode, childNode);
        addDescendants(childNode, record.denpaMen.id);
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

    for (var i = 0; i < directChildren.length; i++) {
      final record = directChildren[i];
      if (!visited.add(record.denpaMen.id)) {
        continue;
      }
      final childNode = Node.Id(record.denpaMen.id);
      labels[record.denpaMen.id] = t.home.catchOrderLabel(
        order: i + 1,
        name: record.denpaMen.name,
      );
      graph.addEdge(rootNode, childNode);
      addDescendants(childNode, record.denpaMen.id);
    }

    final config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 32
      ..levelSeparation = 48
      ..subtreeSeparation = 32
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: OutlinedTitleText(text: qrCode.name ?? qrCode.id),
        ),
        SizedBox(
          height: 320,
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: const EdgeInsets.all(64),
            minScale: 0.2,
            maxScale: 2,
            child: GraphView.builder(
              graph: graph,
              algorithm: BuchheimWalkerAlgorithm(
                config,
                TreeEdgeRenderer(config),
              ),
              builder: (node) {
                final label = labels[node.key!.value] ?? '${node.key!.value}';
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(label),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
