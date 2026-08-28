import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../domain/denpa_men/denpa_men_record.dart';
import '../../widgetbook/denpa_men/denpa_men_data.dart';
import 'lineage_tree_node.dart';
import 'node_info.dart';

@widgetbook.UseCase(name: 'Caught', type: LineageTreeNode, path: 'lineage')
Widget lineageTreeNodeCaughtUseCase(BuildContext context) {
  final denpaMen = DenpaMenData.denpaMen;
  final record = DenpaMenData.denpaMenRecord;
  return LineageTreeNode(
    info: NodeInfo(
      kind: NodeKind.caughtDenpaMen,
      name: denpaMen.name,
      record: record,
    ),
    masterData: DenpaMenData.masterData,
    iconFile: null,
    nodeSize: 64,
    isBred: false,
    hoveredBredId: ValueNotifier<String?>(null),
    denpaMenById: {denpaMen.id: denpaMen},
    incomingSourceKeysById: const {},
    graphNodeKey: denpaMen.id,
    selectionMode: ValueNotifier<bool>(false),
    selectedIds: ValueNotifier<Set<int>>({}),
    onToggleSelection: (_) {},
    onMiddleClick: (_) {},
    onTap: () {},
  );
}

@widgetbook.UseCase(name: 'Bred', type: LineageTreeNode, path: 'lineage')
Widget lineageTreeNodeBredUseCase(BuildContext context) {
  final parentA = DenpaMenData.denpaMen;
  final parentB = DenpaMenData.build('こうたの相方', id: 'denpa-parent-2');
  final bred = DenpaMenData.build(
    'こうたJr',
    id: 'denpa-bred',
    parentIds: [parentA.id, parentB.id],
  );
  final record = DenpaMenRecord(id: 2, denpaMen: bred);
  return LineageTreeNode(
    info: NodeInfo(kind: NodeKind.bredDenpaMen, name: bred.name, record: record),
    masterData: DenpaMenData.masterData,
    iconFile: null,
    nodeSize: 64,
    isBred: true,
    hoveredBredId: ValueNotifier<String?>(bred.id),
    denpaMenById: {parentA.id: parentA, parentB.id: parentB, bred.id: bred},
    incomingSourceKeysById: {
      bred.id: [parentA.id, parentB.id],
    },
    graphNodeKey: parentA.id,
    selectionMode: ValueNotifier<bool>(false),
    selectedIds: ValueNotifier<Set<int>>({}),
    onToggleSelection: (_) {},
    onMiddleClick: (_) {},
    onTap: () {},
    onHoverEnter: () {},
    onHoverExit: () {},
  );
}
