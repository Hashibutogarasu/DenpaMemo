import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _anntena = Anntena(id: 'none', category: AnntenaCategory.other);

void main() {
  final headShape = const HeadShape(id: 'head-a');
  const physique = Physique(id: 'physique-a');
  const personality = Personality(id: 'personality-a');
  const pattern = Pattern(id: 'pattern-a');
  const colorId = 'color-a';

  final masterData = MasterData(
    headShapes: [headShape],
    anntenas: const [_anntena],
    attributes: const [Attribute(id: 'fire', index: 0)],
    abnormalityTypes: const [],
    physiques: const [physique],
    personalities: const [personality],
    patterns: const [pattern],
    bodyColorResistanceRules: const [
      BodyColorResistanceRule(colorId: colorId, attributeResistanceBonuses: []),
    ],
    bodyColorAbnormalityResistanceRules: const [],
    corrections: const [],
  );

  DenpaMen buildDenpaMen(String name) {
    return createDenpaMen(
      name: name,
      bodyColors: const [colorId],
      isSpColor: false,
      headShape: headShape,
      physique: physique,
      personality: personality,
      pattern: pattern,
      anntena: _anntena,
      masterData: masterData,
      maxHappiness: 0,
      maxLevel: 1,
    );
  }

  Future<void> pumpTile(
    WidgetTester tester, {
    required DenpaMen denpaMen,
    bool selectionMode = false,
    bool selected = false,
    ValueChanged<bool>? onSelectedChanged,
    VoidCallback? onTap,
    bool enableLongPressPreview = true,
    ValueChanged<DenpaMen>? onLongPress,
    List<PopupMenuEntry<VoidCallback>> Function(BuildContext)?
    actionMenuItemsBuilder,
  }) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: DenpaMenListTile(
              denpaMen: denpaMen,
              selectionMode: selectionMode,
              selected: selected,
              onSelectedChanged: onSelectedChanged,
              onTap: onTap,
              enableLongPressPreview: enableLongPressPreview,
              onLongPress: onLongPress,
              actionMenuItemsBuilder: actionMenuItemsBuilder,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('selectionMode false: row tap invokes onTap', (tester) async {
    var tapped = false;
    await pumpTile(
      tester,
      denpaMen: buildDenpaMen('individual-a'),
      onTap: () => tapped = true,
    );

    await tester.tap(find.text('individual-a'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets(
    'selectionMode true: row tap invokes onSelectedChanged, not onTap',
    (tester) async {
      var tapped = false;
      bool? changedTo;
      await pumpTile(
        tester,
        denpaMen: buildDenpaMen('individual-a'),
        selectionMode: true,
        onTap: () => tapped = true,
        onSelectedChanged: (value) => changedTo = value,
      );

      await tester.tap(find.text('individual-a'));
      await tester.pump();

      expect(tapped, isFalse);
      expect(changedTo, isTrue);
    },
  );

  testWidgets(
    'enableLongPressPreview false: long-press does not invoke onLongPress',
    (tester) async {
      DenpaMen? pressed;
      await pumpTile(
        tester,
        denpaMen: buildDenpaMen('individual-a'),
        enableLongPressPreview: false,
        onLongPress: (denpaMen) => pressed = denpaMen,
      );

      await tester.longPress(find.text('individual-a'));
      await tester.pumpAndSettle();

      expect(pressed, isNull);
    },
  );

  testWidgets(
    'default enableLongPressPreview: long-press invokes onLongPress with '
    'the denpaMen',
    (tester) async {
      DenpaMen? pressed;
      final denpaMen = buildDenpaMen('individual-a');
      await pumpTile(
        tester,
        denpaMen: denpaMen,
        onLongPress: (value) => pressed = value,
      );

      await tester.longPress(find.text('individual-a'));
      await tester.pumpAndSettle();

      expect(pressed, denpaMen);
    },
  );

  testWidgets(
    'without an action menu builder, no trailing action menu is shown',
    (tester) async {
      await pumpTile(tester, denpaMen: buildDenpaMen('individual-a'));

      expect(find.byIcon(Icons.more_vert), findsNothing);
    },
  );
}
