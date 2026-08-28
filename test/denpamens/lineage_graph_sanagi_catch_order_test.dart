import 'package:data_pack/data_pack.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/lineage/denpa_men_node.dart';
import 'package:denpa_memo/widgets/lineage/lineage_graph.dart';
import 'package:denpa_memo/widgets/lineage/lineage_graph_highlight.dart';

import '../support/file_master_data_repository.dart';
import '../support/lineage_tree_fixture.dart';

const _fixturePath = 'assets/routes/sanagi.json';
const _tsunenoriId = 'kpelvifntq7ju4tz8bll8xjc';
const _takamitsuId = 'cug5bs8ofxmrwi7i31jkzqb2';
const _sanagiId = 'n19girll1iju0wg2ni6w8cs4';

Widget _harness({
  required MasterData masterData,
  required List<QrCodeRecord> qrCodes,
  required List<DenpaMenRecord> denpaMenRecords,
}) {
  return ProviderScope(
    child: TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: LineageGraph(
            qrCodes: qrCodes,
            denpaMenRecords: denpaMenRecords,
            masterData: masterData,
            iconsById: const {},
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets(
    'hovering さなぎ (per $_fixturePath) shows catch-order badge 1 on '
    'つねのり and 2 on たかみつ',
    (WidgetTester tester) async {
      final masterData = await FileMasterDataRepository().load();
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

      expect(byId[_tsunenoriId]!.newCatchOrder(byId), 19);
      expect(byId[_takamitsuId]!.newCatchOrder(byId), 22);

      await tester.pumpWidget(
        _harness(
          masterData: masterData,
          qrCodes: qrCodes,
          denpaMenRecords: denpaMenRecords,
        ),
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

      final nodeByDenpaMenId = {
        for (final node in tester.widgetList<DenpaMenNode>(
          find.byType(DenpaMenNode),
        ))
          node.hoverHighlightPainter!.denpaMenId: node,
      };

      expect(
        nodeByDenpaMenId[_tsunenoriId]!.hoverHighlightPainter!.hoveredBredId.value,
        _sanagiId,
      );
      expect(
        nodeByDenpaMenId[_takamitsuId]!.hoverHighlightPainter!.hoveredBredId.value,
        _sanagiId,
      );

      expect(
        lineageNodeParentBadgeValue(_tsunenoriId, _sanagiId, byId),
        1,
      );
      expect(
        lineageNodeParentBadgeValue(_takamitsuId, _sanagiId, byId),
        2,
      );
    },
  );
}
