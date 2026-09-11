import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tree_graph/tree_graph.dart';

import '../support/file_master_data_repository.dart';
import '../support/lineage_tree_fixture.dart';

const _fixturePath = 'assets/routes/sanagi.json';
const _tsunenoriId = 'kpelvifntq7ju4tz8bll8xjc';
const _takamitsuId = 'cug5bs8ofxmrwi7i31jkzqb2';
const _sanagiId = 'n19girll1iju0wg2ni6w8cs4';

DenpaMenNodeData _data(DenpaMen denpaMen) => DenpaMenNodeData(
  record: DenpaMenRecord(id: 0, denpaMen: denpaMen),
  isBred: false,
);

Widget _harness({
  required List<QrCodeRecord> qrCodes,
  required List<DenpaMenRecord> denpaMenRecords,
}) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(
        body: DenpaMenLineageGraph(
          qrCodes: qrCodes,
          denpaMenRecords: denpaMenRecords,
          selectionMode: false,
          selectedIds: const {},
          onToggleSelection: (_) {},
          onMiddleClickSelect: (_) {},
          onTapNode: (context, denpaMen) {},
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('hovering さなぎ (per $_fixturePath) shows catch-order badge 1 on '
      'つねのり and 2 on たかみつ', (WidgetTester tester) async {
    await FileMasterDataRepository().load();
    final byId = loadLineageTreeFixtureById(_fixturePath);
    final denpaMenRecords = [
      for (final (index, denpaMen) in byId.values.indexed)
        DenpaMenRecord(id: index + 1, denpaMen: denpaMen),
    ];
    final qrCodeIds = {
      for (final denpaMen in byId.values)
        if (denpaMen.qrCodeId != null) denpaMen.qrCodeId!,
    };
    final qrCodes = [
      for (final (index, qrCodeId) in qrCodeIds.indexed)
        QrCodeRecord(
          id: index + 1,
          qrCode: createQrCode(qrCodeId, id: qrCodeId, name: null),
        ),
    ];

    expect(byId[_tsunenoriId]!.catchOrder, 19);
    expect(byId[_takamitsuId]!.catchOrder, 22);

    await tester.pumpWidget(
      _harness(qrCodes: qrCodes, denpaMenRecords: denpaMenRecords),
    );
    await tester.pumpAndSettle();

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(gesture.removePointer);
    await gesture.addPointer(location: Offset.zero);
    await tester.pump();

    final bredFinder = find.ancestor(
      of: find.text(byId[_sanagiId]!.name),
      matching: find.byType(MouseRegion),
    );
    await gesture.moveTo(tester.getCenter(bredFinder.first));
    await tester.pump();

    final nodeBySpecKey = {
      for (final node in tester.widgetList<DenpaMenNode>(
        find.byType(DenpaMenNode),
      ))
        (node.hoverHighlightPainter!
                    as TreeNodeHighlightPainter<DenpaMenNodeData>)
                .specKey:
            node,
    };

    expect(
      (nodeBySpecKey[_tsunenoriId]!.hoverHighlightPainter!
              as TreeNodeHighlightPainter<DenpaMenNodeData>)
          .hoveredKey
          .value,
      _sanagiId,
    );
    expect(
      (nodeBySpecKey[_takamitsuId]!.hoverHighlightPainter!
              as TreeNodeHighlightPainter<DenpaMenNodeData>)
          .hoveredKey
          .value,
      _sanagiId,
    );

    final strategy = DenpaMenHighlightStrategy(denpaMenById: byId);
    expect(
      strategy.badgeText(_data(byId[_tsunenoriId]!), _data(byId[_sanagiId]!)),
      '1',
    );
    expect(
      strategy.badgeText(_data(byId[_takamitsuId]!), _data(byId[_sanagiId]!)),
      '2',
    );
  });
}
