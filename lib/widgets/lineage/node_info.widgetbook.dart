import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'lineage_tree_node.dart';
import 'node_info.dart';
import 'qr_code_node.dart';

@widgetbook.UseCase(name: 'Default', type: NodeInfo, path: 'lineage')
Widget nodeInfoUseCase(BuildContext context) {
  final kind = context.knobs.object.dropdown<NodeKind>(
    label: 'kind',
    options: NodeKind.values,
    labelBuilder: (kind) => kind.name,
  );

  return switch (kind) {
    NodeKind.invisible => const SizedBox(width: 64, height: 64),
    NodeKind.qrCode => const QrCodeNode(rawValue: 'widgetbook-qr', size: 64),
    NodeKind.caughtDenpaMen || NodeKind.bredDenpaMen => LineageTreeNode(
      info: NodeInfo(
        kind: kind,
        name: DenpaMenData.denpaMen.name,
        record: DenpaMenData.denpaMenRecord,
      ),
      masterData: DenpaMenData.masterData,
      iconFile: null,
      nodeSize: 64,
      isBred: kind == NodeKind.bredDenpaMen,
      hoveredBredId: ValueNotifier<String?>(null),
      denpaMenById: {DenpaMenData.denpaMen.id: DenpaMenData.denpaMen},
      incomingSourceKeysById: const {},
      graphNodeKey: DenpaMenData.denpaMen.id,
      selectionMode: ValueNotifier<bool>(false),
      selectedIds: ValueNotifier<Set<int>>({}),
      onToggleSelection: (_) {},
      onMiddleClick: (_) {},
      onTap: () {},
    ),
  };
}
