import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphview/GraphView.dart';

import 'package:denpa_memo/domain/denpa_men/denpa_men_factory.dart';
import 'package:denpa_memo/domain/denpa_men/denpa_men_record.dart';
import 'package:denpa_memo/domain/master_data/anntena.dart';
import 'package:denpa_memo/domain/master_data/body_color_resistance_rule.dart';
import 'package:denpa_memo/domain/master_data/head_shape.dart';
import 'package:denpa_memo/domain/master_data/master_data.dart';
import 'package:denpa_memo/domain/master_data/pattern.dart';
import 'package:denpa_memo/domain/master_data/personality.dart';
import 'package:denpa_memo/domain/master_data/physique.dart';
import 'package:denpa_memo/domain/qr_code/qr_code_factory.dart';
import 'package:denpa_memo/domain/qr_code/qr_code_record.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/widgets/lineage/lineage_graph.dart';

const _anntena = Anntena(id: 'none', category: AnntenaCategory.other);
const _colorId = 'color-a';

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

DenpaMenRecord _record(int id, String denpaMenId, {int? catchOrder}) {
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
      qrCodeId: 'qr-1',
      catchOrder: catchOrder,
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

  void setRecords(List<DenpaMenRecord> value) => setState(() => records = value);

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

  testWidgets(
    'rebuilding with unchanged data does not remount the graph',
    (WidgetTester tester) async {
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
    },
  );
}
