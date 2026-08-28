import 'package:data_pack/data_pack.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphview/GraphView.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/lineage/denpa_men_node.dart';
import 'package:denpa_memo/widgets/lineage/lineage_graph.dart';

const _anntena = Anntena(id: 'none', category: AnntenaCategory.other);
const _colorId = 'red';

final _headShape = HeadShape(
  id: 'head-a',
  abnormalityResistanceBonuses: const {},
);
const _physique = Physique(id: 'physique-a');
const _personality = Personality(id: 'personality-a');
const _pattern = Pattern(id: 'pattern-a');

final _masterData = MasterData(
  headShapes: [_headShape],
  anntenas: const [_anntena],
  attributes: const [],
  abnormalityTypes: const [],
  physiques: const [_physique],
  personalities: const [_personality],
  patterns: const [_pattern],
  bodyColorResistanceRules: const [
    BodyColorResistanceRule(colorId: _colorId, attributeResistanceBonuses: []),
  ],
  bodyColorAbnormalityResistanceRules: const [],
  corrections: const [],
);

DenpaMenRecord _record(
  int id,
  String denpaMenId, {
  int? catchOrder,
  List<String> parentIds = const [],
}) {
  return DenpaMenRecord(
    id: id,
    denpaMen: createDenpaMen(
      id: denpaMenId,
      name: denpaMenId,
      bodyColors: const [_colorId],
      isSpColor: false,
      headShape: _headShape,
      physique: _physique,
      personality: _personality,
      pattern: _pattern,
      anntena: _anntena,
      masterData: _masterData,
      maxHappiness: 0,
      maxLevel: 1,
      qrCodeId: parentIds.isEmpty ? 'qr-1' : null,
      catchOrder: catchOrder,
      parentIds: parentIds,
    ),
  );
}

class _Harness extends StatefulWidget {
  const _Harness({super.key, required this.initial});

  final List<DenpaMenRecord> initial;

  @override
  State<_Harness> createState() => _HarnessState();
}

class _HarnessState extends State<_Harness> {
  late List<DenpaMenRecord> records = widget.initial;

  void setRecords(List<DenpaMenRecord> value) =>
      setState(() => records = value);

  @override
  Widget build(BuildContext context) {
    final qrCode = createQrCode('raw-value', id: 'qr-1', name: 'group');

    return ProviderScope(
      child: TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: LineageGraph(
              qrCodes: [QrCodeRecord(id: 1, qrCode: qrCode)],
              denpaMenRecords: records,
              masterData: _masterData,
              iconsById: const {},
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets(
    'adding an individual while the tree is showing fully remounts the '
    'graph instead of animating the new node in',
    (WidgetTester tester) async {
      final harnessKey = GlobalKey<_HarnessState>();
      await tester.pumpWidget(
        _Harness(key: harnessKey, initial: [_record(1, 'a', catchOrder: 0)]),
      );
      await tester.pumpAndSettle();

      final firstKey = tester.widget<GraphView>(find.byType(GraphView)).key;

      harnessKey.currentState!.setRecords([
        _record(1, 'a', catchOrder: 0),
        _record(2, 'b', catchOrder: 1),
      ]);
      await tester.pumpAndSettle();

      final secondKey = tester.widget<GraphView>(find.byType(GraphView)).key;

      expect(secondKey, isNot(firstKey));
    },
  );

  testWidgets('rebuilding with unchanged data does not remount the graph', (
    WidgetTester tester,
  ) async {
    final harnessKey = GlobalKey<_HarnessState>();
    await tester.pumpWidget(
      _Harness(key: harnessKey, initial: [_record(1, 'a', catchOrder: 0)]),
    );
    await tester.pumpAndSettle();

    final firstKey = tester.widget<GraphView>(find.byType(GraphView)).key;

    harnessKey.currentState!.setRecords([_record(1, 'a', catchOrder: 0)]);
    await tester.pumpAndSettle();

    final secondKey = tester.widget<GraphView>(find.byType(GraphView)).key;

    expect(secondKey, firstKey);
  });

  testWidgets(
    'hovering a bred individual highlights its parents with a badge and '
    'a color border',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _Harness(
          initial: [
            _record(1, 'a', catchOrder: 4),
            _record(2, 'b', catchOrder: 9),
            _record(3, 'c', parentIds: ['a', 'b']),
            _record(4, 'd', catchOrder: 20),
            _record(5, 'e', parentIds: ['c', 'd']),
          ],
        ),
      );
      await tester.pumpAndSettle();

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(gesture.removePointer);
      await gesture.addPointer(location: Offset.zero);
      await tester.pump();

      final bredFinder = find.ancestor(
        of: find.text('e'),
        matching: find.byType(MouseRegion),
      );
      await gesture.moveTo(tester.getCenter(bredFinder.first));
      await tester.pump();

      final painterByDenpaMenId = {
        for (final node in tester.widgetList<DenpaMenNode>(
          find.byType(DenpaMenNode),
        ))
          node.hoverHighlightPainter!.denpaMenId: node.hoverHighlightPainter!,
      };

      expect(painterByDenpaMenId['c']!.hoveredBredId.value, 'e');
      expect(painterByDenpaMenId['d']!.hoveredBredId.value, 'e');
    },
  );
}
