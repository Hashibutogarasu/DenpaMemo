import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide TranslationProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/main.dart';
import 'package:denpa_memo/widgets/add_denpa_men_fab.dart';
import '../support/all_translation_providers.dart';

final _masterData = MasterData(
  headShapes: const [],
  anntenas: const [],
  attributes: const [],
  abnormalityTypes: const [],
  bodyColorResistanceRules: const [],
  bodyColorAbnormalityResistanceRules: const [],
  physiques: const [],
  personalities: const [],
  patterns: const [],
  corrections: const [],
);

/// Reproduces how `home.dart` wires [AddDenpaMenFab] and [AppScaffold]
/// together via a shared expansion [ValueNotifier], since the backdrop
/// itself is rendered by [AppScaffold], not [AddDenpaMenFab].
class _Harness extends StatefulWidget {
  const _Harness();

  @override
  State<_Harness> createState() => _HarnessState();
}

class _HarnessState extends State<_Harness> {
  final _expansion = ValueNotifier(false);
  bool exported = false;

  ValueNotifier<bool> get isExpanded => _expansion;

  @override
  void dispose() {
    _expansion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: AllTranslationProviders(
        child: MaterialApp(
          theme: appLightTheme,
          home: AppScaffold(
            title: const Text('home'),
            floatingActionButtonExpansion: _expansion,
            floatingActionButton: AddDenpaMenFab(
              masterData: _masterData,
              expansionController: _expansion,
              onExport: () => setState(() => exported = true),
            ),
            body: GestureDetector(
              onTap: () {},
              child: const Center(child: Text('body content')),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('closed: the backdrop does not intercept taps on the body', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const _Harness());
    await tester.pumpAndSettle();

    await tester.tap(find.text('body content'));
    await tester.pumpAndSettle();

    // No exception/hit-test failure means the tap reached the body's own
    // GestureDetector, not an opaque backdrop sitting in front of it.
  });

  testWidgets(
    'open: tapping the dimmed backdrop away from the menu closes it',
    (WidgetTester tester) async {
      await tester.pumpWidget(const _Harness());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('単体で追加'), findsOneWidget);
      final state = tester.state<_HarnessState>(find.byType(_Harness));
      expect(state.isExpanded.value, isTrue);

      // Away from both the header controls and the bottom-right FAB stack.
      await tester.tapAt(const Offset(50, 300));
      await tester.pumpAndSettle();

      expect(state.isExpanded.value, isFalse);
    },
  );

  testWidgets('open: the backdrop does not block the mini options themselves', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const _Harness());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('選択項目をエクスポート'), findsOneWidget);
    await tester.tap(find.text('選択項目をエクスポート'));
    await tester.pumpAndSettle();

    final state = tester.state<_HarnessState>(find.byType(_Harness));
    expect(state.exported, isTrue);
  });
}
